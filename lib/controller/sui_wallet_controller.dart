import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:wallet/api/sui_api.dart';
import 'package:wallet/common/toast.dart';
import 'package:wallet/main.dart';
import 'package:wallet/utils/format.dart';
import 'package:wallet/utils/mnemonic.dart';
import 'package:wallet/utils/safe_storage.dart';
import 'package:get/get.dart';
import '../utils/json.dart';
import '../utils/sui_sdk.dart';

class SuiWalletController extends GetxController {
  var safeStorage = SafeStorage();
  var wallets = [].obs;
  var currentWalletAddress = ''.obs;
  var transactions = [].obs;
  var ownedObjectBatch = [].obs;
  var suiGasDefault = 100;

  SuiWallet? get currentWallet {
    if (hasWallet) {
      return wallets[0];
    }
    return null;
  }

  bool get hasWallet {
    return wallets.isNotEmpty;
  }

  get suiBalance {
    return currentWalletBalance[coinSuiType] ?? 0;
  }

  get currentWalletAddressFuzzyed {
    return addressFuzzy(currentWalletAddress.value);
  }

  get currentWalletAddressStandard {
    return addressStandard(currentWalletAddress.value);
  }

  get currentWalletBalance {
    final Map<String, num> acc = {};
    ownedObjectBatch
        .where((element) => isCoin((element as SuiObject).type))
        .forEach((element) {
      final coinType = coinTypeArgRegExp.firstMatch(element.type)?[1];

      if (coinType is String) {
        if (acc[coinType] is num) {
          acc[coinType] = acc[coinType]! + (element.fields['balance'] ?? 0);
        } else {
          acc[coinType] = (element.fields['balance'] ?? 0);
        }
      }
    });

    return acc;
  }

  List<SuiObject> get currentWalletNFTs {
    final List<SuiObject> nfts = [];
    ownedObjectBatch
        .where((element) => !isCoin((element as SuiObject).type))
        .where((element) =>
            (element as SuiObject).dataType == 'moveObject' &&
            (element).hasPublicTransfer)
        .forEach((element) {
      nfts.add(element);
    });

    return nfts;
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

  getOwnedObjectBatch() async {
    if (hasWallet) {
      final objectIds = await currentWallet?._suiApi
          ?.getObjectsOwnedByAddress(currentWalletAddress.string);
      return await currentWallet?._suiApi?.getObjectBatch(objectIds);
    }
    return [];
  }

  getBalance() async {
    ownedObjectBatch.value = await getOwnedObjectBatch();
  }

  getNFTs() async {
    ownedObjectBatch.value = await getOwnedObjectBatch();
  }

  getTransactionsForAddress() async {
    if (hasWallet) {
      transactions.value = await currentWallet?._suiApi
              ?.getTransactionsForAddress(currentWalletAddress.string) ??
          [];
    }
  }

  deleteWallet() async {
    if (hasWallet) {
      safeStorage.deleteAll();
    }
  }

  executeMoveCall(MoveCallTransaction transaction) async {
    try {
      final response = await currentWallet?._suiApi?.suiMoveCall([
        suiWallet.currentWalletAddress.value,
        transaction.packageObjectId,
        transaction.module,
        transaction.function,
        transaction.typeArguments,
        transaction.arguments,
        transaction.gasPayment,
        transaction.gasBudget
      ]);
      final txByte = JSON.resolve(
          json: response.data, path: 'result.txBytes', defaultValue: '');

      return await currentWallet?._suiApi?.suiExecuteTransaction(
          suiWallet.currentWalletAddress.value, await signTxBytes(txByte));
    } catch (e) {
      showError('transferSui', e.toString());
      return null;
    }
  }

  transferSui(String recipient, int amount) async {
    try {
      // sui coins
      final coins = ownedObjectBatch
          .where((element) =>
              isCoin((element as SuiObject).type) && isSuiCoin(element.type))
          .toList();

      // syncAccountState
      // TODO
      if (coins.isEmpty) {
        return null;
      }

      final coin = prepareCoinWithEnoughBalance(
              coins as List<SuiObject>, amount + defaultGasBudgetForMerge)
          as SuiObject;

      final transferSuiTransaction = [
        suiWallet.currentWalletAddress.value,
        getCoinId(coin),
        defaultGasBudgetForTransferSUI,
        recipient,
        amount
      ];

      final response =
          await currentWallet?._suiApi?.suiTransferSui(transferSuiTransaction);
      final txByte = JSON.resolve(
          json: response.data, path: 'result.txBytes', defaultValue: '');
      return await currentWallet?._suiApi?.suiExecuteTransaction(
          suiWallet.currentWalletAddress.value, await signTxBytes(txByte));
    } catch (e) {
      showError('transferSui', e.toString());
      return null;
    }
  }

  signTxBytes(txByte) async {
    final keypair =
        await getKeypairFromMnemonics(currentWallet?._mnemonic ?? '');

    final algorithm = Ed25519();
    keypair.extractPrivateKeyBytes();
    final signature = base64.encode(
        (await algorithm.sign(base64.decode(txByte), keyPair: keypair)).bytes);
    final publicKey = base64.encode((await keypair.extractPublicKey()).bytes);

    return [txByte, "ED25519", signature, publicKey];
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

class MoveCallTransaction {
  final String packageObjectId;
  final String module;
  final String function;
  final List<String> typeArguments;
  final List<String> arguments;
  final String? gasPayment;
  final num gasBudget;
  MoveCallTransaction(
      {required this.packageObjectId,
      required this.module,
      required this.function,
      required this.typeArguments,
      required this.arguments,
      this.gasPayment,
      required this.gasBudget});
}
