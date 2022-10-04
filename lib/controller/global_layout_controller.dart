import 'package:get/get.dart';

class GlobalLayoutController extends GetxController {
  var homeIndex = 0.obs;
  setHomeIndex(i) {
    homeIndex.value = i;
  }
}
