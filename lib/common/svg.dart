import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

svgLogo() {
  return SvgPicture.asset(
    'assets/logo.svg',
    semanticsLabel: 'Logo',
    height: 68,
    width: 68,
  );
}

svgTick({Color? color}) {
  return SvgPicture.asset(
    'assets/tick.svg',
    semanticsLabel: 'Tick',
    height: 20,
    width: 20,
    color: color ?? Colors.white,
  );
}
