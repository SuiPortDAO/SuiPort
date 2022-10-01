import 'package:wallet/controller/global_theme_controller.dart';
import 'package:wallet/controller/sui_wallet_controller.dart';
import 'package:wallet/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet/pages/webview_page.dart';
import 'package:wallet/pages/welcome_page.dart';

SuiWalletController suiWallet = SuiWalletController();
GlobalThemeController theme = GlobalThemeController();

void main() async {
  await suiWallet.loadStorageWallet();
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(context) {
    Get.put(suiWallet);
    Get.put(theme);
    if (suiWallet.hasWallet) {
      return const WebViewXPage();
    } else {
      return const WebViewXPage();
    }
  }
}
