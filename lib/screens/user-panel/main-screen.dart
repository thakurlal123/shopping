import 'package:flutter/material.dart';
import 'package:shoping/utils/AppConstant.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColour,
        title: Center(child: Text(AppConstant.appMainName)),
      ),
    );
  }
}
