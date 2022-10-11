import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wallet/controller/global_layout_controller.dart';
import 'package:wallet/controller/global_theme_controller.dart';
import 'package:wallet/controller/sui_wallet_controller.dart';
import 'package:wallet/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet/pages/welcome_page.dart';

SuiWalletController suiWallet = SuiWalletController();
GlobalThemeController theme = GlobalThemeController();
GlobalLayoutController layout = GlobalLayoutController();

// test CI
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await suiWallet.loadStorageWallet();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: const App(),
    builder: EasyLoading.init(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(context) {
    Get.put(suiWallet);
    Get.put(theme);
    Get.put(layout);
    if (suiWallet.hasWallet) {
      return HomePage();
    } else {
      return const WelcomePage();
    }
  }
}
