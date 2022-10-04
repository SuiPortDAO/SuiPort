const coinType = '0x2::coin::Coin';
const coinSuiType = '0x2::sui::SUI';
RegExp coinTypeArgRegExp = RegExp(r'^0x2::coin::Coin<(.+)>$');

bool isCoin(obj) {
  return (obj?.data?.type as String).startsWith(coinType);
}
