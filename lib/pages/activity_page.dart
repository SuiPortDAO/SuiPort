import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet/common/layout.dart';
import 'package:wallet/common/svg.dart';
import 'package:wallet/pages/activity_detail_page.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      child: Column(
        children: [
          buildColumnGap(16.0),
          Expanded(
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  final transaction = sui.transactions[index] as SuiTansaction;
                  final transactionColor = transaction.isSender
                      ? theme.sendColor
                      : theme.receiveColor;
                  String leftEndText = '';
                  String rightStartText = moneyformat(transaction.amount);
                  String rightEndText = 'SUI';

                  if (transaction.isSender) {
                    leftEndText = 'To ${addressFuzzy(transaction.recipient)}';
                  } else {
                    leftEndText = 'From ${addressFuzzy(transaction.from)}';
                  }
                  if (transaction.recipient.isEmpty) {
                    leftEndText = 'From ${addressFuzzy(transaction.from)}';
                    rightStartText = '';
                    rightEndText = '';
                  }

                  return ListItem(
                    theme: theme,
                    onTap: () {
                      Get.to(() => const ActivityDetailPage(),
                          arguments: transaction);
                    },
                    circleImage: Container(
                      color: theme.backgroundColor1,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Center(
                          child: transaction.isSender
                              ? svgTSend(color: transactionColor)
                              : svgTReceive(color: transactionColor),
                        ),
                      ),
                    ),
                    leftStart: transaction.kind,
                    rightStart: rightStartText,
                    leftEnd: leftEndText,
                    rightEnd: rightEndText,
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
      ),
    );
  }
}
