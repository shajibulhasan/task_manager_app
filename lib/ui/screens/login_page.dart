import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/data/models/user_model.dart';
import 'package:task_management_app/ui/screens/forget_password_email_verify.dart';
import 'package:task_management_app/ui/screens/main_nav_bar_holder_screen.dart';
import 'package:task_management_app/ui/screens/sign_up_screen.dart';
import 'package:task_management_app/ui/widgets/screen_background.dart';

import '../../data/servies/api_caller.dart';
import '../../data/utils/urls.dart';
import '../controller/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signInProgress = false;
  @override
  Widget build(BuildContext context) {
    void onTabForgotPassword() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPasswordEmailVerify()));
    }
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 160,),
                  Text(
                    'Get Started With',
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
                      }else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
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
                      }else if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                    FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _signIn();
                        }
                      },
                      child: Icon(Icons.arrow_forward_ios_outlined),
                    ),
                  const SizedBox(height: 40),

                  Center(
                    child: Column(
                      children: [
                        TextButton(onPressed: onTabForgotPassword,child: Text("Forget Password?")),
                        RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: "Sign Up",
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
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
        ),
      ),
    );
  }


  _clearControllers() {
    _emailController.clear();
    _passwordController.clear();
  }



  Future<void> _signIn() async {
    Map<String, dynamic> signUpData = {
      'email': _emailController.text.trim(),
      'password': _passwordController.text.trim(),
    };
    final ApiResponse response = await ApiCaller.postResponse(
      url: Urls.loginUrl,
      body: signUpData,
    );

    setState(() => _signInProgress = false);

    if(response.isSuccess){
      UserModel model = UserModel.fromJson(response.body['data']);
      String accessToken = response.body['token'];
      await AuthController.saveUserData(model, accessToken);
      _clearControllers();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Successful'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 5),
        ),
      );

      Navigator.push(context, MaterialPageRoute(builder: (context) => const MainNavBarHolderScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.body['data'] ?? 'Login Failed'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
    }
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
