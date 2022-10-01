import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet/controller/sui_wallet_controller.dart';
import 'package:wallet/pages/landing_page.dart';
import '../controller/global_theme_controller.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(context) {
    GlobalThemeController theme = Get.find();
    SuiWalletController sui = Get.find();
    return Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: null,
        body: Container(
          padding: theme.pageGap,
          constraints: const BoxConstraints.expand(),
          child: Column(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to SuiPort Wallet',
                    style: TextStyle(
                        fontSize: 24,
                        color: theme.textColor1,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Connecting you to the decentralized web and SUI network.',
                    style: TextStyle(
                        fontSize: 14,
                        color: theme.textColor2,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )),
              ElevatedButton(
                onPressed: () async {
                  Get.to(const LandingPage());
                },
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all(theme.textColor1),
                    backgroundColor:
                        MaterialStateProperty.all(theme.primaryColor)),
                child: Padding(
                  padding: theme.buttonPadding,
                  child: const Text('Get Started'),
                ),
              ),
            ],
          ),
        ));
  }
}
