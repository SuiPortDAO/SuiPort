import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet/common/layout.dart';
import 'package:wallet/utils/format.dart';

import '../common/svg.dart';
import '../controller/global_theme_controller.dart';
import '../wallet/sui/sui_api.dart';

class ActivityDetailPage extends StatelessWidget {
  const ActivityDetailPage({super.key});

  @override
  Widget build(context) {
    GlobalThemeController theme = Get.find();
    final SuiTansaction translation = Get.arguments;

    detailItem(String label, String value) => Column(
          children: [
            buildColumnGap(18.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(color: theme.textColor2, fontSize: 16),
                ),
                Text(
                  value,
                  style: TextStyle(color: theme.textColor1, fontSize: 16),
                ),
              ],
            ),
          ],
        );

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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Container(
              width: double.infinity,
              height: 320,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: theme.primaryColor2),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildColumnGap(48.0),
                    Text(
                      '${moneyFormat(translation.amount)} SUI',
                      style: TextStyle(
                        color: theme.textColor1,
                        fontSize: 32,
                      ),
                    ),
                    buildColumnGap(12.0),
                    Divider(
                      height: 1,
                      color: theme.dividerColor,
                    ),
                    buildColumnGap(12.0),
                    detailItem('From', addressFuzzy(translation.from)),
                    detailItem(
                        'Gas Fee', '${moneyFormat(translation.txGas)} SUI'),
                    detailItem('Total Amount',
                        '${moneyFormat(translation.amount)} SUI'),
                    detailItem(
                        'Date',
                        dateTimeFormat(DateTime.fromMillisecondsSinceEpoch(
                            translation.timestampMs))),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: BoxDecoration(
                  color: theme.sendColor,
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: svgTSend(height: 52, width: 52),
              ),
            ),
          )
        ],
      ),
    );
  }
}
