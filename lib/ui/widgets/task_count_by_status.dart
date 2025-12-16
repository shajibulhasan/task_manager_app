import 'package:flutter/material.dart';
class TaskCountByStatus extends StatelessWidget {
  const TaskCountByStatus({
    super.key, required this.count, required this.statusLabel,
  });

  final int count;
  final String statusLabel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
        child: Column(
          children: [
            Text('$count',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(statusLabel,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}