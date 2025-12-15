import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/ui/screens/forget_password_verify_otp_screen.dart';
import 'package:task_management_app/ui/screens/login_page.dart';
import 'package:task_management_app/ui/widgets/screen_background.dart';
class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Set New Password',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text("Password should be more than 6 letters and combination of number", style: TextStyle(color: Colors.grey, fontSize: 17),),
              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPasswordVerifyOtpScreen()));
                },
                child: Icon(Icons.arrow_forward_ios_outlined),
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
        ))
    );
  }
}
