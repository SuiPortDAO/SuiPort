const coinType = '0x2::coin::Coin';
RegExp coinTypeArgRegExp = RegExp(r'^0x2::coin::Coin<(.+)>$');

bool isCoin(obj) {
  return (obj?.data?.type as String).startsWith(coinType);
}
