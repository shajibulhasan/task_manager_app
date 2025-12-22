import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';
import '../../data/servies/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar.dart';
import '../widgets/task_card.dart';
import '../widgets/task_manager_app_bar.dart';
class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {


  bool _getProgressTaskCountProgress = false;

  List<TaskModel> _progressTaskList = [];

  Future<void> getAllProgressTask() async {
    _getProgressTaskCountProgress = true;
    setState(() {});

    final ApiResponse response = await ApiCaller.getResponse(
      url: Urls.progressTask,
    );

    _getProgressTaskCountProgress = false;
    setState(() {});
    List<TaskModel> list = [];
    if (response.isSuccess) {
      for (Map<String, dynamic> jsonData in response.body['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
    }else{
      showSnackBar(context, response.errorMessage.toString(), Colors.red);
    }
    _progressTaskList = list;
  }

  @override
  void initState() {
    super.initState();
    getAllProgressTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskManagerAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
            itemCount: _progressTaskList.length,
            itemBuilder: (context,index){
              return TaskCard(
                taskModel: _progressTaskList[index],
                cardColor: Colors.purple,
                refreshParent: (){},
              );

            },
            separatorBuilder: (context,index) => SizedBox(height: 5,)
        ),
      ),
    );
  }
}
