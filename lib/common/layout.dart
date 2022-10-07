import 'package:flutter/material.dart';
import 'package:wallet/main.dart';
import '../controller/global_theme_controller.dart';

buildColumnGap(height) {
  return Container(height: height);
}

buildRowGap(width) {
  return Container(width: width);
}

class ListItem extends StatelessWidget {
  const ListItem(
      {Key? key,
      required this.theme,
      required this.circleImage,
      required this.leftStart,
      required this.leftEnd,
      required this.rightStart,
      required this.rightEnd,
      this.onTap})
      : super(key: key);

  final GlobalThemeController theme;
  final Widget circleImage;
  final String leftStart;
  final String leftEnd;
  final String rightStart;
  final String rightEnd;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: theme.primaryColor2,
      borderRadius: BorderRadius.circular(9),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipOval(child: circleImage),
              buildRowGap(8.0),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          leftStart,
                          style: TextStyle(
                              color: theme.textColor1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          rightStart,
                          style: TextStyle(color: theme.textColor1),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              leftEnd,
                              style: TextStyle(color: theme.textColor2),
                            ),
                            Text(
                              rightEnd,
                              style: TextStyle(color: theme.textColor2),
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

class NFTCard extends StatelessWidget {
  const NFTCard({
    Key? key,
    required GlobalThemeController theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.primaryColor1,
        boxShadow: [
          BoxShadow(
            color: theme.backgroundColor1.withOpacity(0.4),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Flexible(
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://keepsake.gg/assets/images/item-background/front-page-nft.png'))),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: theme.primaryColor2,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Example NFT',
                      style: TextStyle(
                        color: theme.textColor1,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    buildColumnGap(8.0),
                    Text(
                      'Object Id',
                      style: TextStyle(
                        color: theme.textColor2,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
