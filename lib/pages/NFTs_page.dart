import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet/common/layout.dart';

import '../common/svg.dart';
import '../controller/global_theme_controller.dart';

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
  int currentIndex = 0;
  GlobalThemeController theme = Get.find();

  @override
  void initState() {
    cards.addAll([NFTCard(theme: theme), NFTCard(theme: theme)]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width + 80,
          child: AppinioSwiper(
            allowUnswipe: false,
            controller: controller,
            cards: cards,
            onSwipe: _swipe,
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
                  text: 'View Image',
                  icon: svgReceive(),
                  backgroundColor:
                      MaterialStateProperty.all(theme.primaryColor2),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void _swipe(int index, AppinioSwiperDirection direction) {}
}
