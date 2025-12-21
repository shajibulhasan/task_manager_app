import 'package:flutter/material.dart';
import 'package:task_management_app/ui/screens/login_page.dart';
import 'package:task_management_app/ui/screens/main_nav_bar_holder_screen.dart';
import 'package:task_management_app/ui/screens/sign_up_screen.dart';
import 'package:task_management_app/ui/screens/splash_screen.dart';
import 'package:task_management_app/ui/screens/update_profile_screen.dart';

class TaskManagerApp extends StatelessWidget {
  TaskManagerApp({super.key});

 static GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(

        colorSchemeSeed: Colors.green,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.green,
            fixedSize: Size.fromWidth(double.maxFinite),
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        )
      ),
      home: SplashScreen(),
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpScreen(),
        '/navBar': (context) => MainNavBarHolderScreen(),
        '/updateProfile': (context) => UpdateProfileScreen(),
      },
    );
  }
}

