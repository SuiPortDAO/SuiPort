import 'package:wallet/utils/safe_storage.dart';
import 'package:get/get.dart';
import 'package:wallet/wallet/sui/sui_wallet.dart';

import '../wallet/wallet.dart';

class SuiWalletController extends GetxController {
  var safeStorage = SafeStorage();
  var wallets = [].obs;
  var primaryCoinBalance = (0.0).obs;
  var publicAddress = ''.obs;
  var publicAddressFuzzyed = ''.obs;
  var transactions = [].obs;
  var NFTs = [].obs;
  var gasDefault = 0.obs;

  Wallet? get currentWallet {
    if (hasWallet) {
      return wallets[0];
    }
    return null;
  }

  bool get hasWallet {
    return wallets.isNotEmpty;
  }

  loadStorageWallet() async {
    final all = await safeStorage.readAll();
    all.entries
        .map((entry) => entry.value)
        .toList(growable: false)
        .forEach((mnemonic) {
      wallets.add(SuiWallet(mnemonic: mnemonic, update: updateCallback));
    });
    currentWallet?.initWallet();
  }

  updateCallback(
      {primaryCoinBalance,
      publicAddress,
      publicAddressFuzzyed,
      transactions,
      NFTs,
      gasDefault}) {
    this.primaryCoinBalance.value = primaryCoinBalance;
    this.publicAddress.value = publicAddress;
    this.publicAddressFuzzyed.value = publicAddressFuzzyed;
    this.transactions.value = transactions;
    this.NFTs.value = NFTs;
    this.gasDefault.value = gasDefault;
  }

  addWallet(String mnemonic) {
    wallets.add(SuiWallet(mnemonic: mnemonic, update: updateCallback));
    safeStorage.write(
        DateTime.now().millisecondsSinceEpoch.toString(), mnemonic);
    currentWallet?.initWallet();
  }

  deleteWallet() async {
    if (hasWallet) {
      safeStorage.deleteAll();
    }
  }

  executeMoveCall(transaction) {
    return currentWallet?.executeMoveCall(transaction);
  }

  transfer(recipient, amount, coinType) {
    return currentWallet?.transfer(recipient, amount, coinType);
  }
}
