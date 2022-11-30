import 'package:flutter/material.dart';
import 'package:flutter_navigator/my_app_router_delegate.dart';
// import 'package:navigator_2/002-01-mobile-only/router/my_app_router_delegate_01.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final delegate = MyAppRouterDelegate();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Router(routerDelegate: delegate),
    );
  }
}
