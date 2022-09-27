import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet/controller/sui_wallet_controller.dart';
import '../controller/global_theme_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(context) {
    GlobalThemeController theme = Get.find();
    SuiWalletController sui = Get.find();
    sui.getTransactionsForAddress();
    return Scaffold(
        backgroundColor: theme.backgroundColor, body: const Text('home'));
  }
}
