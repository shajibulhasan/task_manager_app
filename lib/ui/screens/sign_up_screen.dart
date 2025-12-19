import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/data/servies/api_caller.dart';
import 'package:task_management_app/data/utils/urls.dart';
import 'package:task_management_app/ui/widgets/screen_background.dart';

import 'login_page.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signUpInProgress = false;

  _clearControllers() {
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _mobileNumberController.clear();
    _passwordController.clear();
  }



  Future<void> _signUp() async {
      setState(() => _signUpInProgress = true);
      Map<String, dynamic> signUpData = {
        'email': _emailController.text.trim(),
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'mobile': _mobileNumberController.text.trim(),
        'password': _passwordController.text.trim(),
      };
      final ApiResponse response = await ApiCaller.postResponse(
          url: Urls.registrationUrl,
          body: signUpData,
      );

      setState(() => _signUpInProgress = false);

      if(response.isSuccess){
        _clearControllers();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Successful'),
          backgroundColor: Colors.green,
            duration: Duration(seconds: 5),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Failed: ${response.body['body']}'),
          backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
          ),
        );
      }


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: ScreenBackground(child:
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  Text(
                    'Join With Us',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
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
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      hintText: 'First Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _mobileNumberController,
                    decoration: InputDecoration(
                      hintText: 'Mobile Number',
                    ),
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
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      else if (value.length < 6) {
                        return 'Password should be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: !_signUpInProgress,
                    replacement: Center(child: CircularProgressIndicator(),),
                    child: FilledButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                            _signUp();
                        }
                      },
                      child: Icon(Icons.arrow_forward_ios_outlined),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: "Sign In",
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                                },
                              ),
                            ],
                          ),
              
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
        )
    );
  }
  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
