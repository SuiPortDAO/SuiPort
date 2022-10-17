import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wallet/common/layout.dart';

import '../common/svg.dart';
import '../controller/global_theme_controller.dart';
import '../controller/sui_wallet_controller.dart';
import '../wallet/sui/sui_wallet.dart';

class NFTsPage extends StatefulWidget {
  const NFTsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NFTsPage> createState() => _NftsPageState();
}

class _NftsPageState extends State<NFTsPage> {
  final AppinioSwiperController controller = AppinioSwiperController();

  List<NFTCard> cards = [];
  GlobalThemeController theme = Get.find();
  SuiWalletController sui = Get.find();

  @override
  void initState() {
    super.initState();
    addCards();
  }

  addCards() {
    final currentWalletNFTsCard =
        sui.NFTs.map((e) => NFTCard(theme: theme, suiObject: e)).toList();
    cards.addAll(currentWalletNFTsCard);
  }

  mintDemoNFT() async {
    const name = 'Example SuiPort NFT';
    const desc = 'An example NFT created by demo Dapp';
    const url =
        'ipfs://bafkreibngqhl3gaa7daob4i2vccziay2jjlp435cf66vhono7nrvww53ty';
    EasyLoading.show(status: 'mint...', maskType: EasyLoadingMaskType.black);
    await sui.executeMoveCall(MoveCallTransaction(
      packageObjectId: '0x2',
      module: 'devnet_nft',
      function: 'mint',
      typeArguments: [],
      arguments: [name, desc, url],
      gasPayment: null,
      gasBudget: 10000,
    ));
    setState(() {
      addCards();
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) {
      return Center(
        child: SizedBox(
          height: 60,
          width: 240,
          child: CardButton(
            theme: theme,
            text: 'Mint An Demo NFT',
            icon: svgSend(height: 18),
            backgroundColor: MaterialStateProperty.all(theme.primaryColor1),
            onPressed: () {
              mintDemoNFT();
            },
          ),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width + 80,
          child: AppinioSwiper(
            allowUnswipe: false,
            controller: controller,
            cards: cards,
            onSwipe: _swipe,
            onEnd: () {
              addCards();
            },
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
              top: 50,
              bottom: 40,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(38),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: CardButton(
                  theme: theme,
                  text: 'Send NFT',
                  icon: svgSend(height: 18),
                  backgroundColor:
                      MaterialStateProperty.all(theme.primaryColor1),
                ),
              ),
              buildRowGap(8.0),
              Expanded(
                flex: 1,
                child: CardButton(
                  theme: theme,
                  text: 'View Image',
                  icon: svgView(),
                  backgroundColor:
                      MaterialStateProperty.all(theme.primaryColor2),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void _swipe(int index, AppinioSwiperDirection direction) {}
}
