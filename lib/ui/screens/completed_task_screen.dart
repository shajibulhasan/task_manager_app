import 'package:flutter/material.dart';
import 'package:task_management_app/ui/widgets/task_card.dart';
import 'package:task_management_app/ui/widgets/task_manager_app_bar.dart';

import '../../data/models/task_model.dart';
import '../../data/servies/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar.dart';
class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {

  bool _getCompleteTaskCountProgress = false;

  List<TaskModel> _completeTaskList = [];

  Future<void> getAllCompleteTask() async {
    _getCompleteTaskCountProgress = true;
    setState(() {});

    final ApiResponse response = await ApiCaller.getResponse(
      url: Urls.completeTask,
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
    _completeTaskList = list;
  }

  @override
  void initState() {
    super.initState();
    getAllCompleteTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskManagerAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
            itemCount: _completeTaskList.length,
            itemBuilder: (context,index){
              Text('');
              return TaskCard(
                taskModel: _completeTaskList[index],
                cardColor: Colors.green,
                refreshParent: (){},
              );
            },
            separatorBuilder: (context,index) => SizedBox(height: 5,)
        ),
      ),
    );
  }
}
