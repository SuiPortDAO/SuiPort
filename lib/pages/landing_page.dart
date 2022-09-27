import 'package:wallet/pages/import_mnemonic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/global_theme_controller.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  @override
  Widget build(context) {
    GlobalThemeController theme = Get.find();
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 120, bottom: 120),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: double.infinity),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                color: theme.holderBackGroundColor,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(ImportMnemonic());
                },
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all(theme.textColor1),
                    backgroundColor:
                        MaterialStateProperty.all(theme.primaryColor)),
                child: const Padding(
                  padding: EdgeInsets.only(
                    top: 12,
                    bottom: 12,
                    left: 80,
                    right: 80,
                  ),
                  child: Text('创建钱包'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
