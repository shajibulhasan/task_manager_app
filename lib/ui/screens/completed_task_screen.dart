import 'package:flutter/material.dart';
import 'package:task_management_app/ui/widgets/task_card.dart';
import 'package:task_management_app/ui/widgets/task_manager_app_bar.dart';
class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskManagerAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
            itemCount: 10,
            itemBuilder: (context,index){
              return TaskCard(status: 'Completed', cardColor: Colors.green,);
            },
            separatorBuilder: (context,index) => SizedBox(height: 5,)
        ),
      ),
    );
  }
}
