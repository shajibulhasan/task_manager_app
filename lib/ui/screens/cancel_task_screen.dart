import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';
import '../../data/servies/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar.dart';
import '../widgets/task_card.dart';
import '../widgets/task_manager_app_bar.dart';
class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {


  bool _getCancelledTaskCountProgress = false;

  List<TaskModel> _CancelledTaskList = [];

  Future<void> getAllCancelledTask() async {
    _getCancelledTaskCountProgress = true;
    setState(() {});

    final ApiResponse response = await ApiCaller.getResponse(
      url: Urls.cancelledTask,
    );

    _getCancelledTaskCountProgress = false;
    setState(() {});
    List<TaskModel> list = [];
    if (response.isSuccess) {
      for (Map<String, dynamic> jsonData in response.body['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
    }else{
      showSnackBar(context, response.errorMessage.toString(), Colors.red);
    }
    _CancelledTaskList = list;
  }

  @override
  void initState() {
    super.initState();
    getAllCancelledTask();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskManagerAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
            itemCount: _CancelledTaskList.length,
            itemBuilder: (context,index){
              return TaskCard(
                taskModel: _CancelledTaskList[index],
                cardColor: Colors.red,
                refreshParent: (){},
              );
            },
            separatorBuilder: (context,index) => SizedBox(height: 5,)
        ),
      ),
    );
  }
}
