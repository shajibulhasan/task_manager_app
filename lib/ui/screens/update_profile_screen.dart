// dart
// lib/ui/screens/update_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_management_app/ui/widgets/screen_background.dart';
import 'package:task_management_app/ui/widgets/task_manager_app_bar.dart';

import '../widgets/photo_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? selectedImage;

  Future<void> pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      if (!mounted) return;
      setState(() {
        selectedImage = image;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskManagerAppBar(),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              Text(
                'Update Profile',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 15),
              PhotoPicker(onTap: pickImage, selectedPhoto: selectedImage),
              const SizedBox(height: 15),
              TextFormField(decoration: const InputDecoration(hintText: 'Email')),
              const SizedBox(height: 10),
              TextFormField(decoration: const InputDecoration(hintText: 'First Name')),
              const SizedBox(height: 10),
              TextFormField(decoration: const InputDecoration(hintText: 'Last Name')),
              const SizedBox(height: 10),
              TextFormField(decoration: const InputDecoration(hintText: 'Mobile Number')),
              const SizedBox(height: 10),
              TextFormField(decoration: const InputDecoration(hintText: 'Password')),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () {},
                child: const Icon(Icons.arrow_forward_ios_outlined),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
