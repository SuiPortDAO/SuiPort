const coinType = '0x2::coin::Coin';
const coinSuiType = '0x2::sui::SUI';
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
