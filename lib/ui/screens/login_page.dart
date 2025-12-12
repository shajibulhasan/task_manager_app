import 'package:flutter/material.dart';
import 'package:task_management_app/ui/screens/forget_password_email_verify.dart';
import 'package:task_management_app/ui/widgets/screen_background.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(height: 20),
            
                  FilledButton(
                    onPressed: () {},
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
    );
  }
}
