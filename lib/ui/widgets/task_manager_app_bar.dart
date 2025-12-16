import 'package:flutter/material.dart';
import 'package:task_management_app/ui/screens/update_profile_screen.dart';
import 'package:task_management_app/ui/screens/update_profile_screen.dart';
class TaskManagerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskManagerAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfileScreen()));
        },
        child: Row(
          children: [
            const CircleAvatar(),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Soaib",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        
                Text(
                  "abc@gmail.com",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}