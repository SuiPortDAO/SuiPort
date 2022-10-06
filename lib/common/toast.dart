import 'package:flutter/material.dart';
import 'package:get/get.dart';

showError(title, message) {
  Get.showSnackbar(GetSnackBar(
    duration: 2.seconds,
    snackPosition: SnackPosition.TOP,
    borderRadius: 24,
    title: title,
    message: message,
    animationDuration: 2.seconds,
    backgroundColor: Colors.red,
  ));
}
