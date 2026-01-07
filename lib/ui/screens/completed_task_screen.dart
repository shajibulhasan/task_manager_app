import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/ui/widgets/task_card.dart';
import 'package:task_management_app/ui/widgets/task_manager_app_bar.dart';
import '../../providers/task_provider.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    Future.wait([taskProvider.fetchNewTaskByStatus('Completed')]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskManagerAppBar(),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.separated(
              itemCount: taskProvider.completedTasks.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskModel: taskProvider.completedTasks[index],
                  cardColor: Colors.blue,
                  refreshParent: () {
                    loadData();
                  },
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 4);
              },
            ),
          );
        },
      ),
    );
  }
}
