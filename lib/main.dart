import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/app_theme.dart';
import 'package:todo_app/modules/edit_task/edit_task.dart';
import 'package:todo_app/modules/login_screen/login_screen.dart';
import 'package:todo_app/modules/singup_screen/singup_screen.dart';

import 'firebase_options.dart';
import 'layout/home_screen.dart';
import 'modules/splash/splash_view.dart';

  Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
         SharedPreferences pref = await SharedPreferences.getInstance();
  var email = pref.getString('email');
  print (email);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

 

  runApp( TodoApp(
    email: email == null ? LoginScreen.routeName : HomeScreen.routeName,
  ));
}

class TodoApp extends StatelessWidget {
 TodoApp({required this.email ,  super.key});
String email ;
  @override
 Widget build(BuildContext context){


    return MaterialApp(
      theme: AppTheme.LgihtTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    
      initialRoute: email == null ? LoginScreen.routeName : HomeScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        SplashView.routeName: (_) => const SplashView(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        SingUpScreen.routeName: (context) => const SingUpScreen(),
      },
    );
  }
  
}
