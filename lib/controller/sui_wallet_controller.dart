import 'package:wallet/api/sui_api.dart';
import 'package:wallet/utils/format.dart';
import 'package:wallet/utils/mnemonic.dart';
import 'package:wallet/utils/safe_storage.dart';
import 'package:get/get.dart';
import '../utils/sui_sdk.dart';

class SuiWalletController extends GetxController {
  var safeStorage = SafeStorage();
  var wallets = [].obs;
  var currentWalletBalance = {}.obs;
  var currentWalletAddress = ''.obs;
  var transactions = [].obs;

  SuiWallet? get currentWallet {
    if (hasWallet) {
      return wallets[0];
    }
    return null;
  }

  bool get hasWallet {
    return wallets.isNotEmpty;
  }

  get suiBalnce {
    return currentWalletBalance[coinSuiType] ?? 0;
  }

  get currentWalletAddressFuzzyed {
    return addressFuzzy(currentWalletAddress.value);
  }

  get currentWalletAddressStandard {
    return addressStandard(currentWalletAddress.value);
  }

  get transactionsSend {
    return transactions.takeWhile((element) => element.isSender);
  }

  get transactionsReceive {
    return transactions.takeWhile((element) => !element.isSender);
  }

  loadStorageWallet() async {
    final all = await safeStorage.readAll();
    all.entries
        .map((entry) => entry.value)
        .toList(growable: false)
        .forEach((mnemonic) {
      wallets.add(SuiWallet(mnemonic: mnemonic, suiApi: SuiApi()));
    });
    if (hasWallet) {
      initCurrentWallet();
    }
  }

  addWallet(String mnemonic) {
    wallets.add(SuiWallet(mnemonic: mnemonic, suiApi: SuiApi()));
    safeStorage.write(
        DateTime.now().millisecondsSinceEpoch.toString(), mnemonic);
    if (hasWallet) {
      initCurrentWallet();
    }
  }

  initCurrentWallet() async {
    if (hasWallet) {
      currentWalletAddress.value = await getSuiAddress(
          await getKeypairFromMnemonics(currentWallet?._mnemonic ?? ''));
    }
  }

  getBalance() async {
    if (hasWallet) {
      final Map<String, num> acc = {};
      final suiObjectInfo = await currentWallet?._suiApi
          ?.getObjectsOwnedByAddress(currentWalletAddress.string);
      final objectIds = suiObjectInfo
          ?.map((suiObjectInfo) => suiObjectInfo.objectId)
          .toList();
      (await currentWallet?._suiApi?.getObjectBatch(objectIds))
          ?.where((element) => isCoin(element))
          .forEach((element) {
        final coinType =
            coinTypeArgRegExp.firstMatch(element?.data?.type ?? '')?[1];

        if (coinType is String) {
          if (acc[coinType] is num) {
            acc[coinType] =
                acc[coinType]! + (element?.data?.fields?.balance ?? 0);
          } else {
            acc[coinType] = (element?.data?.fields?.balance ?? 0);
          }
        }
      });

      currentWalletBalance.value = acc;
    }
  }

  getTransactionsForAddress() async {
    if (hasWallet) {
      print('update transactions');
      transactions.value = await currentWallet?._suiApi
              ?.getTransactionsForAddress(currentWalletAddress.string) ??
          [];
    }
  }
}

class SuiWallet {
  String? _mnemonic;
  SuiApi? _suiApi;
  SuiWallet({required String mnemonic, required SuiApi suiApi}) {
    _mnemonic = mnemonic;
    _suiApi = suiApi;
  }
}
