import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/global_theme_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(context) {
    GlobalThemeController theme = Get.find();
    return Scaffold(
        backgroundColor: theme.backgroundColor, body: const Text('home'));
  }
}
