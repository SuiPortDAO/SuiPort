import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet/common/layout.dart';
import 'package:wallet/controller/sui_wallet_controller.dart';
import 'package:wallet/pages/landing_page.dart';
import '../common/svg.dart';
import '../controller/global_theme_controller.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(context) {
    GlobalThemeController theme = Get.find();
    SuiWalletController sui = Get.find();

    _buildSupportRow(text) => Row(
          children: [
            svgTick(color: theme.successColor),
            buildRowGap(8.0),
            Text(
              text,
              style: TextStyle(
                  fontSize: 16,
                  color: theme.textColor1,
                  fontWeight: FontWeight.bold),
            )
          ],
        );

    return Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: theme.backgroundColor,
          elevation: 0,
        ),
        body: Container(
          padding: theme.pageGap,
          constraints: const BoxConstraints.expand(),
          child: Column(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildColumnGap(60.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      svgLogo(),
                      buildRowGap(12.0),
                      Text(
                        'SuiPort',
                        style: TextStyle(fontSize: 32, color: theme.textColor1),
                      )
                    ],
                  ),
                  buildColumnGap(50.0),
                  Text(
                    'Welcome to SuiPort Wallet',
                    style: TextStyle(
                        fontSize: 26,
                        color: theme.textColor1,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 38),
                    child: Text(
                      'Connecting you to the decentralized web and SUI network.',
                      style: TextStyle(
                          fontSize: 16,
                          color: theme.textColor2,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  _buildSupportRow('Buy, store, send and swap tokens'),
                  buildColumnGap(18.0),
                  _buildSupportRow('Explore blockchain apps'),
                  buildColumnGap(18.0),
                  _buildSupportRow('Find the best price every time'),
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
                        MaterialStateProperty.all(theme.primaryColor1)),
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
