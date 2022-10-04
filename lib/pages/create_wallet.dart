import 'package:wallet/common/layout.dart';
import 'package:wallet/common/svg.dart';
import 'package:wallet/pages/import_mnemonic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/global_theme_controller.dart';

class CreateWalletPage extends StatelessWidget {
  const CreateWalletPage({super.key});
  @override
  Widget build(context) {
    GlobalThemeController theme = Get.find();
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
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
                        child: svgCreateWallet(),
                      ),
                      Text(
                        'Create',
                        style: TextStyle(
                            color: theme.svgColor1,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'New Wallet',
                        style: TextStyle(
                            color: theme.svgColor1,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      buildColumnGap(12.0),
                      Text(
                        'Creating a wallet generates new recovery passphrase. Using it you can backup and restore your wallet.',
                        style: TextStyle(
                            fontSize: 16,
                            color: theme.textColor2,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(const ImportMnemonic());
              },
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(theme.textColor1),
                  backgroundColor:
                      MaterialStateProperty.all(theme.primaryColor1)),
              child: Padding(
                padding: theme.buttonPadding,
                child: const Text('Create Wallte Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
