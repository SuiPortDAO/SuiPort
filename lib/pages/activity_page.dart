import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet/common/layout.dart';
import 'package:wallet/common/svg.dart';
import 'package:wallet/utils/format.dart';
import '../api/sui_api.dart';
import '../controller/global_theme_controller.dart';
import '../controller/sui_wallet_controller.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});
  @override
  Widget build(BuildContext context) {
    SuiWalletController sui = Get.find();
    GlobalThemeController theme = Get.find();
    sui.getTransactionsForAddress();
    return Column(
      children: [
        buildColumnGap(18.0),
        Expanded(
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                final transaction = sui.transactions[index] as SuiTansaction;
                return ListItem(
                  theme: theme,
                  circleImage: Container(
                    color: transaction.isSender
                        ? theme.sendColor
                        : theme.receiveColor,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Center(
                        child: svgTSend(),
                      ),
                    ),
                  ),
                  leftStart: transaction.kind,
                  rightStart: moneyformat(transaction.amount),
                  leftEnd: addressFuzzy(transaction.from),
                  rightEnd: 'SUI',
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 8,
                );
              },
              itemCount: sui.transactions.length),
        )
      ],
    );
  }
}
