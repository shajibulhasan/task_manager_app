import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/ui/controller/auth_controller.dart';
import 'package:task_management_app/ui/screens/update_profile_screen.dart';
import 'package:task_management_app/providers/auth_provider.dart';
class TaskManagerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskManagerAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userModel = authProvider.userModel;
    final String profilePhoto = userModel?.photo ?? '';
    return AppBar(
      backgroundColor: Colors.green,
      title: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfileScreen()));
        },
        child: Row(
          children: [
            CircleAvatar(
              child: profilePhoto.isNotEmpty ? Image.memory(jsonDecode(profilePhoto)) : Icon(Icons.person),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  userModel!.firstName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        
                Text(
                  userModel.email,
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
          onPressed: () {
            authProvider.logout();
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}