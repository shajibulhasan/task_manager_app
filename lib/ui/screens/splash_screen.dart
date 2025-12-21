import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_management_app/ui/controller/auth_controller.dart';
import 'package:task_management_app/ui/screens/login_page.dart';
import 'package:task_management_app/ui/utils/asset_path.dart';
import 'package:task_management_app/ui/widgets/screen_background.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  Future<void> moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 2));
    final bool isLoggedIn = await AuthController.isUserLoggeIn();
    if(isLoggedIn){
      Navigator.pushReplacementNamed(context, '/navBar');
    }else{
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moveToNextScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          ScreenBackground(
            child: Center(
              child: SvgPicture.asset(
                AssetPaths.logoSVG,
                height: 150,
              ),
            ),
          ),
    );
  }
}
