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
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        elevation: 0.0,
        leading: null,
      ),
      body: Container(
        padding: theme.pageGap,
        constraints: const BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              color: theme.holderBackGroundColor,
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.to(const ImportMnemonic());
                  },
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(theme.textColor1),
                      backgroundColor:
                          MaterialStateProperty.all(theme.primaryColor)),
                  child: Padding(
                    padding: theme.buttonPadding,
                    child: const Text('Import new wallet'),
                  ),
                ),
                Container(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(const ImportMnemonic());
                  },
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(theme.textColor1),
                      backgroundColor:
                          MaterialStateProperty.all(theme.primaryColor)),
                  child: Padding(
                    padding: theme.buttonPadding,
                    child: const Text('Create new wallet'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
