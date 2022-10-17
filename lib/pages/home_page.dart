import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:wallet/common/layout.dart';
import 'package:wallet/common/svg.dart';
import 'package:wallet/controller/global_layout_controller.dart';
import 'package:wallet/controller/sui_wallet_controller.dart';
import 'package:wallet/pages/NFTs_page.dart';
import 'package:wallet/pages/activity_page.dart';
import 'package:wallet/pages/apps_dart.dart';
import 'package:wallet/pages/coins_page.dart';
import 'package:wallet/pages/my_drawer.dart';
import '../controller/global_theme_controller.dart';

class HomePage extends StatelessWidget {
  // const HomePage({super.key});
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(context) {
    GlobalThemeController theme = Get.find();
    SuiWalletController sui = Get.find();
    GlobalLayoutController layout = Get.find();
    const appBarLabels = ['SuiPort', 'NFTs', 'Apps', 'Activity'];
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: theme.backgroundColor1,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: svgMenu(),
          )
        ],
        leading: Obx(
          () {
            final text = Text(
              appBarLabels[layout.homeIndex.value],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            );
            if (layout.homeIndex.value > 0) {
              return Row(children: [buildRowGap(15.0), text]);
            }
            return Row(
              children: [
                buildRowGap(15.0),
                svgLogo(height: 28.0, width: 28.0),
                buildRowGap(8.0),
                text
              ],
            );
          },
        ),
        leadingWidth: 120,
      ),
      backgroundColor: theme.backgroundColor1,
      body: Obx(() => [
            const CoinsPage(),
            const NFTsPage(),
            const AppsPage(),
            const ActivityPage()
          ][layout.homeIndex.value]),
      bottomNavigationBar: Obx(() => SalomonBottomBar(
            currentIndex: layout.homeIndex.value,
            items: [
              SalomonBottomBarItem(
                  icon: svgCoins(color: theme.primaryColor1),
                  title: const Text(
                    'Coins',
                  ),
                  selectedColor: theme.primaryColor1),
              SalomonBottomBarItem(
                  icon: svgNFTs(color: theme.primaryColor1),
                  title: const Text(
                    'NFTs',
                  )),
              SalomonBottomBarItem(
                  icon: svgApps(color: theme.primaryColor1),
                  title: const Text(
                    'Apps',
                  )),
              SalomonBottomBarItem(
                  icon: svgActivity(color: theme.primaryColor1),
                  title: Text(
                    appBarLabels[3],
                  ))
            ],
            onTap: (i) => layout.setHomeIndex(i),
          )),
      endDrawer: MyDrawer(),
    );
  }
}
