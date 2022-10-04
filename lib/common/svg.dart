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

svgBack({Color? color}) {
  return SvgPicture.asset(
    'assets/back.svg',
    semanticsLabel: 'Back',
    height: 25,
    width: 25,
    color: color ?? Colors.white,
  );
}

svgNewTo() {
  return SvgPicture.asset(
    'assets/new_to.svg',
    semanticsLabel: 'New To',
    height: 320,
    width: 320,
  );
}

svgCreateWallet() {
  return SvgPicture.asset(
    'assets/create_wallet.svg',
    semanticsLabel: 'Create Wallet',
    height: 320,
    width: 320,
  );
}

svgBackupWallet() {
  return SvgPicture.asset(
    'assets/backup_wallet.svg',
    semanticsLabel: 'Backup Wallet',
    height: 320,
    width: 320,
  );
}
