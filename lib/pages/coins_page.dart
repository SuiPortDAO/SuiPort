import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wallet/common/layout.dart';
import 'package:wallet/common/svg.dart';
import 'package:wallet/main.dart';

import '../controller/global_theme_controller.dart';
import '../controller/sui_wallet_controller.dart';

class CoinsPage extends StatelessWidget {
  const CoinsPage({super.key});
  @override
  Widget build(BuildContext context) {
    GlobalThemeController theme = Get.find();
    SuiWalletController sui = Get.find();
    sui.getBalance();
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildColumnGap(12.0),
          Text(
            'Avalible balance',
            style: TextStyle(color: theme.textColor2),
          ),
          buildColumnGap(12.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Obx(() => Text(
                    '${sui.suiBalnce}',
                    style: TextStyle(
                        color: theme.textColor1,
                        fontSize: 38,
                        fontWeight: FontWeight.bold),
                  )),
              buildRowGap(4.0),
              Text(
                'sui',
                style: TextStyle(color: theme.textColor2, fontSize: 24),
              )
            ],
          ),
          Row(
            children: [
              Text(
                '${suiWallet.currentWalletAddressFormated}',
                style: TextStyle(color: theme.textColor2),
              ),
              IconButton(
                  onPressed: () {
                    Get.showSnackbar(GetSnackBar(
                      message: 'Copied',
                      duration: 0.5.seconds,
                      snackPosition: SnackPosition.TOP,
                      maxWidth: 120,
                      backgroundColor: theme.primaryColor1,
                      borderRadius: 24,
                      messageText: Text(
                        'Copied',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: theme.textColor1),
                      ),
                      animationDuration: 0.5.seconds,
                    ));
                    Clipboard.setData(
                        ClipboardData(text: sui.currentWalletAddressStandard));
                  },
                  icon: svgCopy())
            ],
          ),
          buildColumnGap(18.0),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CardButton(
                  theme: theme,
                  text: 'Send',
                  icon: svgSend(),
                  backgroundColor:
                      MaterialStateProperty.all(theme.primaryColor1),
                ),
              ),
              buildRowGap(8.0),
              Expanded(
                flex: 1,
                child: CardButton(
                  theme: theme,
                  text: 'Receive',
                  icon: svgReceive(),
                  backgroundColor:
                      MaterialStateProperty.all(theme.primaryColor2),
                ),
              )
            ],
          ),
          buildColumnGap(8.0),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CardButton(
                  theme: theme,
                  text: 'Stack & Earn',
                  icon: svgStack(),
                  backgroundColor:
                      MaterialStateProperty.all(theme.primaryColor2),
                ),
              ),
              buildRowGap(8.0),
              Expanded(
                flex: 1,
                child: CardButton(
                  theme: theme,
                  text: 'Swap',
                  icon: svgSwap(),
                  backgroundColor:
                      MaterialStateProperty.all(theme.primaryColor2),
                ),
              )
            ],
          ),
          buildColumnGap(24.0),
          Text(
            'All Assets',
            style: TextStyle(fontSize: 16, color: theme.textColor1),
          ),
          buildColumnGap(12.0),
          Expanded(
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 8,
                    );
                  },
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Material(
                      color: theme.primaryColor2,
                      borderRadius: BorderRadius.circular(9),
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              ClipOval(
                                  child: Image.asset(
                                'assets/usdt.png',
                                height: 42,
                              )),
                              buildRowGap(8.0),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Tether',
                                          style: TextStyle(
                                              color: theme.textColor1,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          '0.00 USDT',
                                          style: TextStyle(
                                              color: theme.textColor1),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '\$1.00',
                                              style: TextStyle(
                                                  color: theme.textColor2),
                                            ),
                                            Text(
                                              '\$0.00',
                                              style: TextStyle(
                                                  color: theme.textColor2),
                                            )
                                          ],
                                        ),
                                        Row()
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}

class CardButton extends StatelessWidget {
  const CardButton(
      {Key? key,
      required this.theme,
      required this.text,
      required this.icon,
      required this.backgroundColor})
      : super(key: key);

  final GlobalThemeController theme;
  final String text;
  final Widget icon;
  final MaterialStateProperty<Color> backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            )),
            foregroundColor: MaterialStateProperty.all(theme.textColor1),
            backgroundColor: backgroundColor),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(color: theme.textColor1, fontSize: 16),
              ),
              icon
            ],
          ),
        ));
  }
}
