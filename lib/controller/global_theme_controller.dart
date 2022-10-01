import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class GlobalThemeController extends GetxController {
  var primaryColor = const Color.fromARGB(255, 11, 9, 152);
  var backgroundColor = const Color.fromRGBO(26, 27, 39, 1);
  var holderBackGroundColor = const Color.fromARGB(255, 90, 90, 94);
  var textColor1 = const Color.fromARGB(255, 255, 255, 255);
  var textColor2 = const Color.fromARGB(255, 93, 87, 87);
  var inputBackgroudColor = const Color.fromARGB(255, 48, 48, 52);

  var pageGap = const EdgeInsets.only(top: 25, bottom: 40, left: 40, right: 40);

  var buttonPadding = const EdgeInsets.only(
    top: 12,
    bottom: 12,
    left: 60,
    right: 60,
  );
}
