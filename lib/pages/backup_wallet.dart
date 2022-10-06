import 'package:wallet/common/layout.dart';
import 'package:wallet/common/svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet/pages/home_page.dart';
import '../controller/global_theme_controller.dart';
import '../controller/sui_wallet_controller.dart';

class BackupWalletPage extends StatelessWidget {
  const BackupWalletPage({super.key});
  @override
  Widget build(context) {
    GlobalThemeController theme = Get.find();
    SuiWalletController suiWallet = Get.find();
    return Scaffold(
      backgroundColor: theme.backgroundColor1,
      appBar: AppBar(
        backgroundColor: theme.backgroundColor1,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: svgBack()),
      ),
      body: Container(
        padding: theme.pageGap,
        constraints: const BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: svgBackupWallet(),
                      ),
                      Text(
                        'Wallet',
                        style: TextStyle(
                          color: theme.svgColor1,
                          fontSize: 26,
                        ),
                      ),
                      Text(
                        'Successfully Created',
                        style: TextStyle(
                          color: theme.svgColor1,
                          fontSize: 24,
                        ),
                      ),
                      buildColumnGap(12.0),
                      Text(
                        'Backup Recovery Passphrase.',
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.textColor2,
                        ),
                      ),
                      buildColumnGap(12.0),
                      TextFormField(
                        readOnly: true,
                        initialValue: Get.arguments,
                        maxLines: 3,
                        style: TextStyle(
                            color: theme.textColor1,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          fillColor: theme.inputBackgroudColor,
                          filled: true,
                          border: InputBorder.none,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await suiWallet.addWallet(Get.arguments);
                Get.offAll(const HomePage());
              },
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(theme.textColor1),
                  backgroundColor:
                      MaterialStateProperty.all(theme.primaryColor1)),
              child: Padding(
                padding: theme.buttonPadding,
                child: const Text('Done'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
