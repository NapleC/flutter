import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: Text('Login'))),
    );
  }
}
