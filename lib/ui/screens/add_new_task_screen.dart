import 'package:flutter/material.dart';
import 'package:task_management_app/ui/widgets/screen_background.dart';
import 'package:task_management_app/ui/widgets/task_manager_app_bar.dart';
class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskManagerAppBar(),
      body: ScreenBackground(child:
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80,),
            Text("Add New Task",
            style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 15,),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Task Title',
              ),
            ),
            SizedBox(height: 15,),
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Task Description',
              ),
            ),
            SizedBox(height: 15,),
            FilledButton(onPressed: (){}, child: Icon(Icons.arrow_forward_ios_outlined))
          ],
        ),
      )),
    );
  }
}
