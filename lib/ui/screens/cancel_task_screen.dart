import 'package:flutter/material.dart';

import '../widgets/task_card.dart';
import '../widgets/task_manager_app_bar.dart';
class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskManagerAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
            itemCount: 10,
            itemBuilder: (context,index){
              return TaskCard(status: 'Cancel', cardColor: Colors.red,);
            },
            separatorBuilder: (context,index) => SizedBox(height: 5,)
        ),
      ),
    );
  }
}
