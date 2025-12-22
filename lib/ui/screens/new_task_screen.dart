import 'package:flutter/material.dart';
import 'package:task_management_app/ui/screens/add_new_task_screen.dart';

import '../../data/models/task_model.dart';
import '../../data/models/task_status_count.dart';
import '../../data/servies/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar.dart';
import '../widgets/task_card.dart';
import '../widgets/task_count_by_status.dart';
import '../widgets/task_manager_app_bar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getTaskStatusCountProgress = false;
  bool _getCompleteTaskCountProgress = false;

  List<TaskStatusCountModel> _taskStatusCountList = [];
  List<TaskModel> _newTaskList = [];

  Future<void> getAllTaskCount() async {
    _getTaskStatusCountProgress = true;
    setState(() {});

    final ApiResponse response = await ApiCaller.getResponse(
      url: Urls.taskCount,
    );

    _getTaskStatusCountProgress = false;
    setState(() {});
    List<TaskStatusCountModel> list = [];
    if (response.isSuccess) {
      for (Map<String, dynamic> jsonData in response.body['data']) {
        list.add(TaskStatusCountModel.formJson(jsonData));
      }
    }else{
      showSnackBar(context, response.errorMessage.toString(), Colors.red);
    }
    _taskStatusCountList = list;
  }

  Future<void> getAllCompleteTask() async {
    _getCompleteTaskCountProgress = true;
    setState(() {});

    final ApiResponse response = await ApiCaller.getResponse(
      url: Urls.newTask,
    );

    _getCompleteTaskCountProgress = false;
    setState(() {});
    List<TaskModel> list = [];
    if (response.isSuccess) {
      for (Map<String, dynamic> jsonData in response.body['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
    }else{
      showSnackBar(context, response.errorMessage.toString(), Colors.red);
    }
    _newTaskList = list;
  }

  @override
  void initState() {
    super.initState();
    getAllTaskCount();
    getAllCompleteTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskManagerAppBar(),
      body: Column(
        children: [
          SizedBox(height: 15),
          SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _taskStatusCountList.length,
              itemBuilder: (context, index) {
                return TaskCountByStatus(
                  count: _taskStatusCountList[index].count,
                  statusLabel: _taskStatusCountList[index].status,
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 5),
            ),
          ),

          Expanded(
            child: ListView.separated(
              itemCount: _newTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskModel: _newTaskList[index],
                  cardColor: Colors.blue.shade400,
                  refreshParent: (){

                  },
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 5),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
