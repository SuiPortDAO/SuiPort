import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/layout.dart';
import '../controller/global_theme_controller.dart';
import '../controller/sui_wallet_controller.dart';

class AppItem {
  final String icon;
  final String title;
  final String description;
  final List<String> tags;
  AppItem(
      {required this.icon,
      required this.title,
      required this.description,
      required this.tags});
}

class AppsPage extends StatelessWidget {
  const AppsPage({super.key});
  @override
  Widget build(BuildContext context) {
    SuiWalletController sui = Get.find();
    GlobalThemeController theme = Get.find();
    sui.getTransactionsForAddress();

    final List<AppItem> apps = [
      AppItem(
          icon: 'https://sui.io/img/sui-social.jpg',
          title: 'Sui NFT Mint',
          description: 'Mint your NFTs on the Sui Network',
          tags: ['NFT'])
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      child: Column(
        children: [
          buildColumnGap(16.0),
          Expanded(
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  final app = apps[index];
                  return ListItem(
                    theme: theme,
                    onTap: () {},
                    circleImage: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(app.icon))),
                    ),
                    leftStart: app.title,
                    leftEnd: app.description,
                    rightEnd: '',
                    rightStart: '',
                    tags: app.tags,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 8,
                  );
                },
                itemCount: apps.length),
          )
        ],
      ),
    );
  }
}
