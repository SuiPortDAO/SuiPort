import 'package:intl/intl.dart';

final f = DateFormat('yyyy-MM-dd HH:mm', 'en_US');
final oCcy = NumberFormat("#,##0.00", 'en_US');

addressFuzzy(String address) {
  if (address.isEmpty) {
    return '';
  }
  if (address.startsWith('0x')) {
    address = address.substring(2);
  }
  final start = address.substring(0, 6);
  final end = address.substring(address.length - 3);
  return '0x$start...$end';
}

addressStandard(String address) {
  if (address.isEmpty) {
    return '';
  }
  if (address.startsWith('0x')) {
    return address;
  }
  return '0x$address';
}

moneyFormat(money) {
  return oCcy.format(money);
}

dateTimeFormat(date) {
  return f.format(date);
}
