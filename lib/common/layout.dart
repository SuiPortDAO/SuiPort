import 'package:flutter/material.dart';
import 'package:wallet/api/sui_api.dart';
import 'package:wallet/utils/format.dart';
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
      this.tags,
      this.onTap})
      : super(key: key);

  final GlobalThemeController theme;
  final Widget circleImage;
  final String leftStart;
  final String leftEnd;
  final String rightStart;
  final String rightEnd;
  final List<String>? tags;
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
                        Row(
                          children: [
                            Text(
                              leftStart,
                              style: TextStyle(
                                  color: theme.textColor1,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            ...tags?.map((tag) => Row(
                                      children: [
                                        buildRowGap(8.0),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 2),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              border: Border.all(
                                                  color: theme.primaryColor1,
                                                  width: 1)),
                                          child: Text(
                                            tag,
                                            style: TextStyle(
                                                color: theme.textColor1,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    )) ??
                                []
                          ],
                        ),
                        Text(
                          rightStart,
                          style: TextStyle(color: theme.textColor1),
                        )
                      ],
                    ),
                    buildColumnGap(6.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            leftEnd,
                            style: TextStyle(color: theme.textColor2),
                          ),
                        ),
                        Text(
                          rightEnd,
                          style: TextStyle(color: theme.textColor2),
                        )
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
      required this.backgroundColor,
      this.center,
      this.onPressed})
      : super(key: key);

  final GlobalThemeController theme;
  final String text;
  final Widget icon;
  final MaterialStateProperty<Color> backgroundColor;
  final void Function()? onPressed;
  final bool? center;

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
        onPressed: () {
          onPressed?.call();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: center ?? false
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(color: theme.textColor1, fontSize: 16),
              ),
              buildRowGap(8.0),
              icon
            ],
          ),
        ));
  }
}

class NFTCard extends StatelessWidget {
  const NFTCard({
    Key? key,
    required this.theme,
    required this.suiObject,
  }) : super(key: key);

  final GlobalThemeController theme;
  final SuiObject suiObject;

  @override
  Widget build(BuildContext context) {
    String mediaUrl = (suiObject.fields['url'] ?? '');
    mediaUrl =
        mediaUrl.replaceFirst(RegExp(r'^ipfs:\/\/'), 'https://ipfs.io/ipfs/');
    final name = suiObject.fields['name'] ?? '';
    final objectId = suiObject.fields['id']?['id'] ?? '';

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.primaryColor2,
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
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(mediaUrl))),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: theme.textColor1,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                buildColumnGap(8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Object Id',
                      style: TextStyle(
                        color: theme.textColor2,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      addressFuzzy(objectId),
                      style: TextStyle(
                        color: theme.textColor2,
                        fontSize: 15,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
