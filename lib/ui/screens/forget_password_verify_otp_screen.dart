import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../widgets/screen_background.dart';
class ForgetPasswordVerifyOtpScreen extends StatefulWidget {
  const ForgetPasswordVerifyOtpScreen({super.key});

  @override
  State<ForgetPasswordVerifyOtpScreen> createState() => _ForgetPasswordVerifyOtpScreenState();
}

class _ForgetPasswordVerifyOtpScreenState extends State<ForgetPasswordVerifyOtpScreen> {
  @override
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
                'PIN Verification',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text("A 6 digits OTP sent to your email address", style: TextStyle(color: Colors.grey, fontSize: 17),),
              const SizedBox(height: 15),



              PinCodeTextField(
                length: 6,
                keyboardType: TextInputType.number,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedColor: Colors.greenAccent,
                  inactiveColor: Colors.grey.shade100,

                ),
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                appContext: context,
              ),





              const SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPasswordVerifyOtpScreen()));
                },
                child: Text("Verify"),
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
                              color: Colors.green.shade600,
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
        ))
    );
  }
}

