import 'package:flutter/material.dart';
import 'package:task_management_app/data/models/task_model.dart';
class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key, required this.cardColor, required this.taskModel, required this.refreshParent,
  });

  final TaskModel taskModel;
  final Color cardColor;
  final VoidCallback refreshParent;




  @override
  Widget build(BuildContext context) {

    void _showChangeStatusDialog(){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text('Change Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('New'),
                trailing: taskModel.status == 'New' ? Icon(Icons.done, color: Colors.green,) : null,
              ), ListTile(
                title: Text('Progress'),
                trailing: taskModel.status == 'Progress' ? Icon(Icons.done, color: Colors.green,) : null,
              ),  ListTile(
                title: Text('Cancelled'),
                trailing: taskModel.status == 'Cancelled' ? Icon(Icons.done, color: Colors.green,) : null,
              ),  ListTile(
                title: Text('Completed'),
                trailing: taskModel.status == 'Completed' ? Icon(Icons.done, color: Colors.green,) : null,
              )
            ],
          ),
        );
        });
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        color: Colors.white,
        child: ListTile(
          title: Text(taskModel.title,
          style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(taskModel.description),
              SizedBox(height: 5),
              Text('Date: ${taskModel.createdDate}'),
              Row(
                children: [
                  Chip(
                    label: Text(taskModel.status),
                    backgroundColor: cardColor,
                    labelStyle: TextStyle(color: Colors.white),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),

                  ),
                  Spacer(),
                  IconButton(onPressed: (){
                    _showChangeStatusDialog();
                  }, icon: Icon(Icons.edit_note_outlined, color: Colors.green,)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Colors.red,)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}