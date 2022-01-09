import 'package:flutter/material.dart';
import 'package:lock_screen/auth_pin_code_screen.dart';
import 'package:lock_screen/create_pin_code_screen.dart';
import 'package:lock_screen/menu_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MenuScreen(),
      routes: <String, WidgetBuilder>{
        '/1': (context) => const CreatePinCodeScreen(),
        '/1/2': (context) => const AuthPinCodeScreen()
      },
    );
  }
}
