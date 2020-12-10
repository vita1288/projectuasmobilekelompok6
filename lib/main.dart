import 'package:flutter/material.dart';
import 'package:projectuasmobilekelompok6/models/constant.dart';
import 'package:projectuasmobilekelompok6/view/addmoney_screen.dart';
import 'package:projectuasmobilekelompok6/view/splash_screen.dart';
import 'view/home_screen.dart';
import 'view/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: kLightGreen,
        accentColor: kLightGreen,
        iconTheme: IconThemeData(color: kLightGreen),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        SplashScreen.id: (context) => SplashScreen(),
        AddMoneyScreen.id : (context) => AddMoneyScreen(),
      },
    );
  }
}
