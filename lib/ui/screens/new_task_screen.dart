import 'package:flutter/material.dart';
import 'package:task_management_app/ui/screens/add_new_task_screen.dart';

import '../widgets/task_card.dart';
import '../widgets/task_count_by_status.dart';
import '../widgets/task_manager_app_bar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
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
              itemCount: 4,
              itemBuilder: (context, index) {
                return TaskCountByStatus(
                  count: index * 5,
                  statusLabel: index == 0
                      ? 'New Tasks'
                      : index == 1
                      ? 'Completed'
                      : index == 2
                      ? 'Cancelled'
                      : 'In Progress',
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 5)
            ),
          ),

          Expanded(
            child: ListView.separated(
                itemCount: 10,
                itemBuilder: (context, index){
                  return TaskCard();
                },
                separatorBuilder: (context, index) => SizedBox(height: 5,)
            ),
          )

        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewTaskScreen()));
      }, child: Icon(Icons.add),),
    );
  }
}


