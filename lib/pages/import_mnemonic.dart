import 'package:wallet/controller/sui_wallet_controller.dart';
import 'package:wallet/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/global_theme_controller.dart';

class ImportMnemonic extends StatelessWidget {
  const ImportMnemonic({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalThemeController theme = Get.find();
    SuiWalletController suiWallet = Get.find();
    final mnemonicController = TextEditingController();
    return Scaffold(
        backgroundColor: theme.backgroundColor1,
        body: Padding(
          padding: const EdgeInsets.only(top: 120, bottom: 120),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'mnemonics',
                          style: TextStyle(
                            color: theme.textColor1,
                          ),
                        ),
                        Container(
                          height: 20,
                        ),
                        TextField(
                          controller: mnemonicController,
                          cursorColor: theme.primaryColor1,
                          maxLines: 4,
                          style: TextStyle(
                            color: theme.textColor1,
                          ),
                          decoration: InputDecoration(
                            fillColor: theme.inputBackgroudColor,
                            filled: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    )),
                ElevatedButton(
                  onPressed: () async {
                    await suiWallet.addWallet(mnemonicController.text);
                    Get.offAll(HomePage());
                  },
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(theme.textColor1),
                      backgroundColor:
                          MaterialStateProperty.all(theme.primaryColor1)),
                  child: const Padding(
                    padding: EdgeInsets.only(
                      top: 12,
                      bottom: 12,
                      left: 80,
                      right: 80,
                    ),
                    child: Text('下一步'),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
