import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wallet/utils/format.dart';

import '../common/layout.dart';
import '../common/svg.dart';
import '../controller/global_theme_controller.dart';
import '../controller/sui_wallet_controller.dart';
import '../utils/sui_sdk.dart';

class SendSheet extends StatefulWidget {
  const SendSheet({Key? key}) : super(key: key);

  @override
  _SendSheetState createState() => _SendSheetState();
}

class _SendSheetState extends State<SendSheet> {
  final amountController = TextEditingController();
  final addressController = TextEditingController();
  GlobalThemeController theme = Get.find();
  SuiWalletController sui = Get.find();

  bool isChanged = false;

  @override
  void initState() {
    super.initState();
    amountController.addListener(() {
      setState(() {
        if (amountController.text.isNotEmpty) {
          isChanged = true;
        }
      });
    });
    addressController.addListener(() {
      setState(() {
        if (addressController.text.isNotEmpty) {
          isChanged = true;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    addressController.dispose();
  }

  validateAmount(String val) {
    if (!isChanged) {
      return null;
    }
    if (val.isEmpty) {
      return 'Amount is a required field';
    }

    if (val.isNotEmpty && int.parse(val) > sui.suiBalance - sui.suiGasDefault) {
      return 'Amount must be less than ${moneyFormat(sui.suiBalance - sui.suiGasDefault)} SUI';
    }

    if (val.isNotEmpty && int.parse(val) == 0) {
      return 'Amount must be greater than or equal to 1 SUI';
    }
  }

  validateSuiAddress(String val) {
    if (!isChanged) {
      return null;
    }
    if (val.isEmpty) {
      return '''Recipient's address is a required field''';
    }
    if (!isValidSuiAddress(val.replaceAll(RegExp(r'^0x'), ''))) {
      return 'Invalid address. Please check again.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      color: theme.primaryColor2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildColumnGap(8.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              buildRowGap(48.0),
              Expanded(
                  child: Text(
                'Send',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.textColor1,
                    fontSize: 16),
              )),
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: svgClose())
            ],
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildColumnGap(8.0),
                Text(
                  'Amount',
                  style: TextStyle(color: theme.textColor2),
                ),
                buildColumnGap(8.0),
                TextFormField(
                  controller: amountController,
                  cursorColor: theme.primaryColor1,
                  style: TextStyle(
                    color: theme.textColor1,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      errorText: validateAmount(amountController.text),
                      fillColor: theme.inputBackgroudColor,
                      filled: true,
                      border: InputBorder.none,
                      hintText: 'Total SUI to send',
                      hintStyle: TextStyle(color: theme.textColor2)),
                ),
                buildColumnGap(8.0),
                Text(
                  'Address',
                  style: TextStyle(color: theme.textColor2),
                ),
                buildColumnGap(8.0),
                TextFormField(
                  controller: addressController,
                  cursorColor: theme.primaryColor1,
                  style: TextStyle(
                    color: theme.textColor1,
                  ),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      errorText: validateSuiAddress(addressController.text),
                      fillColor: theme.inputBackgroudColor,
                      filled: true,
                      border: InputBorder.none,
                      hintText: '0x..',
                      hintStyle: TextStyle(color: theme.textColor2)),
                ),
                buildColumnGap(18.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: theme.backgroundColor1,
                      borderRadius: BorderRadius.circular(4.0)),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            moneyFormat(
                                int.tryParse(amountController.text) ?? 0),
                            style: TextStyle(
                                color: theme.textColor1,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                          buildRowGap(8.0),
                          Text(
                            'SUI',
                            style: TextStyle(
                              color: theme.textColor2,
                            ),
                          ),
                        ],
                      ),
                      buildColumnGap(12.0),
                      Divider(
                        height: 1,
                        color: theme.dividerColor,
                      ),
                      buildColumnGap(12.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Gas Fee',
                            style: TextStyle(
                              color: theme.textColor2,
                            ),
                          ),
                          Text(
                            '${moneyFormat(sui.suiGasDefault)} SUI',
                            style: TextStyle(
                              color: theme.textColor1,
                            ),
                          ),
                        ],
                      ),
                      buildColumnGap(12.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount',
                            style: TextStyle(
                              color: theme.textColor2,
                            ),
                          ),
                          Text(
                            '${moneyFormat((int.tryParse(amountController.text) ?? 0) + sui.suiGasDefault)} SUI',
                            style: TextStyle(
                              color: theme.textColor1,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(38),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CardButton(
                    theme: theme,
                    center: true,
                    text: 'Send Coins Now',
                    icon: svgSend(height: 18),
                    onPressed: () {
                      sendCoinsNow();
                    },
                    backgroundColor:
                        MaterialStateProperty.all(theme.primaryColor1),
                  ),
                ),
              ],
            ),
          ),
          buildColumnGap(24.0)
        ],
      ),
    );
  }

  sendCoinsNow() {
    if (!isChanged) {
      return;
    }

    if (validateAmount(amountController.text) == null &&
        validateSuiAddress(addressController.text) == null) {
      print('Go....');
    }
  }
}
