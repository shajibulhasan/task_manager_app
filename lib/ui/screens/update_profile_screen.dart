// dart
// lib/ui/screens/update_profile_screen.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_management_app/data/models/user_model.dart';
import 'package:task_management_app/ui/controller/auth_controller.dart';
import 'package:task_management_app/ui/widgets/screen_background.dart';
import 'package:task_management_app/ui/widgets/task_manager_app_bar.dart';

import '../../data/servies/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/photo_picker.dart';
import '../widgets/snack_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? selectedImage;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserModel user = AuthController.userModel!;
    emailController.text = user.email;
    firstNameController.text = user.firstName;
    lastNameController.text = user.lastName;
    mobileNumberController.text = user.mobile;
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
      );
      if (image == null) return;
      if (!mounted) return;
      setState(() {
        selectedImage = image;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskManagerAppBar(),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
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
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: firstNameController,
                  decoration: const InputDecoration(hintText: 'First Name'),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: lastNameController,
                  decoration: const InputDecoration(hintText: 'Last Name'),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: mobileNumberController,
                  decoration: const InputDecoration(hintText: 'Mobile Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    else if (!RegExp(r'^\d{11}$').hasMatch(value)) {
                      return 'Please enter a valid 11-digit mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(hintText: 'Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    }
                    else if (value.length < 6) {
                      return 'Password should be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      updateProfile();
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios_outlined),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
  bool isLogging = false;
  Future<void> updateProfile() async {
    isLogging = true;
    setState(() {

    });
    final Map<String, dynamic> requestBody = {
      'email': emailController.text.trim(),
      'firstName': firstNameController.text.trim(),
      'lastName': lastNameController.text.trim(),
      'mobile': mobileNumberController.text.trim(),
    };
    if(passwordController.text.trim().isNotEmpty){
      requestBody['password'] = passwordController.text.trim();
    }

    String ? encodedImage;
    if(selectedImage != null) {
      List<int> bytes = await selectedImage!.readAsBytes();
      encodedImage = jsonEncode(bytes);
      requestBody['photo'] = encodedImage;
    }

    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.updateProfile,
      body: requestBody,
    );

    isLogging = false;
    setState(() {

    });

    if(response.isSuccess){
      UserModel model = UserModel(
          id: AuthController.userModel!.id,
          email: emailController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          mobile: mobileNumberController.text,
          photo: encodedImage ?? AuthController.userModel!.photo,
      );
      AuthController.updateUserData(model);
      showSnackBar(context, "Profile Updated Successfully", Colors.green);

    }else{
      showSnackBar(context, response.errorMessage!, Colors.red);
    }
  }
}
