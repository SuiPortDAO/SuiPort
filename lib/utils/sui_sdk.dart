const coinType = '0x2::coin::Coin';
const coinSuiType = '0x2::sui::SUI';
const suiAddressLength = 20;

RegExp coinTypeArgRegExp = RegExp(r'^0x2::coin::Coin<(.+)>$');

final txKindToTxt = {
  'TransferObject': 'Object transfer',
  'Call': 'Call',
  'Publish': 'Publish',
  'TransferSui': 'Sui transfer',
  'ChangeEpoch': 'Change epoch',
};

bool isCoin(type) {
  return type.startsWith(coinType);
}

bool isValidSuiAddress(String value) {
  return isHex(value) && getHexByteLength(value) == suiAddressLength;
}

bool isHex(String value) {
  return RegExp(r'^(0x|0X)?[a-fA-F0-9]+$').hasMatch(value) &&
      value.length % 2 == 0;
}

num getHexByteLength(String value) {
  return RegExp(r'/^(0x|0X)/').hasMatch(value)
      ? (value.length - 2) / 2
      : value.length / 2;
}
