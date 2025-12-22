import 'package:flutter/material.dart';
import 'package:task_management_app/data/models/task_model.dart';
import 'package:task_management_app/ui/widgets/snack_bar.dart';

import '../../data/servies/api_caller.dart';
import '../../data/utils/urls.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.cardColor,
    required this.taskModel,
    required this.refreshParent,
  });

  final TaskModel taskModel;
  final Color cardColor;
  final VoidCallback refreshParent;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _changeStatusInProgress = false;
  bool _isDelete = false;

  Future<void> _changeStatus(String status) async {
    _changeStatusInProgress = true;
    final ApiResponse response = await ApiCaller.getResponse(
      url: Urls.changeStatus(widget.taskModel.id, status),
    );

    _changeStatusInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      widget.refreshParent();
      showSnackBar(context, 'Task Updated', Colors.green);
    } else {
      showSnackBar(context, response.errorMessage.toString(), Colors.red);
    }
  }

  Future<void> deleteTask() async {
    _isDelete = true;
    setState(() {});
    final ApiResponse response = await ApiCaller.getResponse(
      url: Urls.deleteTaskUrl(widget.taskModel.id),
    );
    _isDelete = false;
    setState(() {});
    if(response.isSuccess){
      widget.refreshParent();
      showSnackBar(context, 'Task Deleted', Colors.green);
    }else{
      showSnackBar(context, response.errorMessage.toString(), Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});

    void _showChangeStatusDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Change Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    _changeStatus('New');
                    Navigator.pop(context);
                  },
                  title: Text('New'),
                  trailing: widget.taskModel.status == 'New'
                      ? Icon(Icons.done, color: Colors.green)
                      : null,
                ),
                ListTile(
                  onTap: () {
                    _changeStatus('Progress');
                    Navigator.pop(context);
                  },
                  title: Text('Progress'),
                  trailing: widget.taskModel.status == 'Progress'
                      ? Icon(Icons.done, color: Colors.green)
                      : null,
                ),
                ListTile(
                  onTap: () {
                    _changeStatus('Cancelled');
                    Navigator.pop(context);
                  },
                  title: Text('Cancelled'),
                  trailing: widget.taskModel.status == 'Cancelled'
                      ? Icon(Icons.done, color: Colors.green)
                      : null,
                ),
                ListTile(
                  onTap: () {
                    _changeStatus('Completed');
                    Navigator.pop(context);
                  },
                  title: Text('Completed'),
                  trailing: widget.taskModel.status == 'Completed'
                      ? Icon(Icons.done, color: Colors.green)
                      : null,
                ),
              ],
            ),
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        color: Colors.white,
        child: ListTile(
          title: Text(
            widget.taskModel.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.taskModel.description),
              SizedBox(height: 5),
              Text('Date: ${widget.taskModel.createdDate}'),
              Row(
                children: [
                  Chip(
                    label: Text(widget.taskModel.status),
                    backgroundColor: widget.cardColor,
                    labelStyle: TextStyle(color: Colors.white),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      _showChangeStatusDialog();
                    },
                    icon: Icon(Icons.edit_note_outlined, color: Colors.green),
                  ),
                  IconButton(
                    onPressed: () {
                      deleteTask();
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
