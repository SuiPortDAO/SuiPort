import 'package:bip39/bip39.dart' as bip39;
import 'package:cryptography/cryptography.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:hex/hex.dart';
import 'package:sha3/sha3.dart';

String generateMnemonic() {
  return bip39.generateMnemonic();
}

Future<SimpleKeyPair> getKeypairFromMnemonics(String mnemonic) async {
  final seed = bip39.mnemonicToSeed(mnemonic);
  final seedBytes = seed;
  KeyData data =
      await ED25519_HD_KEY.derivePath("m/44'/784'/0'/0'/0'", seedBytes);
  final algorithm = Ed25519();
  final keyPair = await algorithm.newKeyPairFromSeed(data.key);
  return keyPair;
}

getSuiAddress(SimpleKeyPair keyPair) async {
  final publicKey = (await keyPair.extractPublicKey()).bytes;
  final prefixPublicKey = [0, ...publicKey];
  var k = SHA3(256, SHA3_PADDING, 256);
  k.update(prefixPublicKey);
  return HEX.encode(k.digest()).substring(0, 40);
}
