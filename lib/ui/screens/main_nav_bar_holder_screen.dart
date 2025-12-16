import 'package:flutter/material.dart';
import 'package:task_management_app/ui/screens/new_task_screen.dart';
import 'package:task_management_app/ui/screens/progress_task_screen.dart';

class MainNavBarHolderScreen extends StatefulWidget {
  const MainNavBarHolderScreen({super.key});

  @override
  State<MainNavBarHolderScreen> createState() => _MainNavBarHolderScreenState();
}

class _MainNavBarHolderScreenState extends State<MainNavBarHolderScreen> {
  int _selectedIndex = 0;
  List<Widget> screens = [
    NewTaskScreen(),
    ProgressTaskScreen(),
    ProgressTaskScreen(),
    ProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },

        destinations: [
          NavigationDestination(icon: Icon(Icons.add_task), label: 'New Task'),
          NavigationDestination(
            icon: Icon(Icons.done_all_outlined),
            label: 'Completed',
          ),
          NavigationDestination(
            icon: Icon(Icons.cancel_outlined),
            label: 'Cancelled',
          ),
          NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
        ],
      ),
    );
  }
}
