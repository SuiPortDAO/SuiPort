import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:wallet/wallet/sui/sui_api.dart';
import 'package:wallet/wallet/wallet.dart';
import '../../common/toast.dart';
import '../../utils/format.dart';
import '../../utils/json.dart';
import '../../utils/mnemonic.dart';
import './sui_sdk.dart';

class SuiChainNetwork {}

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

class SuiChain implements Chain {
  SuiChain({required this.network});
  SuiChainNetwork network;

  @override
  String name = 'DevNet';
}

class SuiWallet implements Wallet {
  SuiWallet({required this.mnemonic, required this.update});

  String mnemonic;
  Function({
    num primaryCoinBalance,
    String publicAddress,
    String publicAddressFuzzyed,
    List transactions,
    List NFTs,
    num gasDefault,
  }) update;

  List _ownedObjectBatch = [];
  Map _balance = {};
  List _NFTs = [];
  List _transactions = [];
  String _publicAddress = '';
  String _publicAddressFuzzy = '';
  num _primaryCoinBalance = 0.0;

  final SuiApi _suiApi = SuiApi();

  @override
  String getName() {
    return 'Sui';
  }

  @override
  Future<Map<String, num>> getBalance() async {
    final Map<String, num> acc = {};
    _ownedObjectBatch
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

  @override
  Future<num> getPrimaryCoinBalance() async {
    final balance = await getBalance();
    return (balance[coinSuiType] ?? 0).toDouble();
  }

  @override
  Future<String> getPublicAddress() async {
    final address =
        await getSuiAddress(await getKeypairFromMnemonics(mnemonic));
    return addressStandard(address);
  }

  @override
  Future<void> initWallet() async {
    _publicAddress = await getPublicAddress();
    _publicAddressFuzzy = addressFuzzy(_publicAddress);
    _ownedObjectBatch = await getOwnedObjectBatch();
    _balance = await getBalance();
    _NFTs = await getNFTs();
    _transactions = await getTransactions();
    _primaryCoinBalance = await getPrimaryCoinBalance();
    _update();
  }

  @override
  Future<void> updateWallet() async {
    _publicAddress = await getPublicAddress();
    _publicAddressFuzzy = addressFuzzy(_publicAddress);
    _ownedObjectBatch = await getOwnedObjectBatch();
    _balance = await getBalance();
    _NFTs = await getNFTs();
    _transactions = await getTransactions();
    _primaryCoinBalance = await getPrimaryCoinBalance();
    _update();
  }

  @override
  List<Chain> getChains() {
    return [SuiChain(network: SuiChainNetwork())];
  }

  @override
  Future<bool> transfer(String recipient, int amount, String coinType) async {
    try {
      // sui coins
      final coins = _ownedObjectBatch
          .where((element) =>
              isCoin((element as SuiObject).type) && isSuiCoin(element.type))
          .toList();

      // syncAccountState
      // TODO
      if (coins.isEmpty) {
        return false;
      }

      final coin = prepareCoinWithEnoughBalance(
              coins as List<SuiObject>, amount + defaultGasBudgetForMerge)
          as SuiObject;

      final transferSuiTransaction = [
        _publicAddress,
        getCoinId(coin),
        defaultGasBudgetForTransferSUI,
        recipient,
        amount
      ];

      final response = await _suiApi.suiTransferSui(transferSuiTransaction);
      final txByte = JSON.resolve(
          json: response.data, path: 'result.txBytes', defaultValue: '');
      await _suiApi.suiExecuteTransaction(
          _publicAddress, await signTxBytes(txByte));

      updateWallet();

      return true;
    } catch (e) {
      showError('transferSui', e.toString());
      return false;
    }
  }

  @override
  Future<List> getTransactions() async {
    return await _suiApi.getTransactionsForAddress(_publicAddress);
  }

  @override
  Future<List> getNFTs() async {
    final List<SuiObject> nfts = [];
    _ownedObjectBatch
        .where((element) => !isCoin((element as SuiObject).type))
        .where((element) =>
            (element as SuiObject).dataType == 'moveObject' &&
            (element).hasPublicTransfer)
        .forEach((element) {
      nfts.add(element);
    });

    return nfts;
  }

  @override
  Future<bool> executeMoveCall(MoveCallTransaction transaction) async {
    try {
      final response = await _suiApi.suiMoveCall([
        _publicAddress,
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

      await _suiApi.suiExecuteTransaction(
          _publicAddress, await signTxBytes(txByte));

      updateWallet();

      return true;
    } catch (e) {
      showError('transferSui', e.toString());
      return false;
    }
  }

  signTxBytes(txByte) async {
    final keypair = await getKeypairFromMnemonics(mnemonic);

    final algorithm = Ed25519();
    keypair.extractPrivateKeyBytes();
    final signature = base64.encode(
        (await algorithm.sign(base64.decode(txByte), keyPair: keypair)).bytes);
    final publicKey = base64.encode((await keypair.extractPublicKey()).bytes);

    return [txByte, "ED25519", signature, publicKey];
  }

  getOwnedObjectBatch() async {
    final objectIds = await _suiApi.getObjectsOwnedByAddress(_publicAddress);
    return await _suiApi.getObjectBatch(objectIds);
  }

  _update() async {
    update(
      primaryCoinBalance: _primaryCoinBalance,
      publicAddress: _publicAddress,
      publicAddressFuzzyed: _publicAddressFuzzy,
      transactions: _transactions,
      NFTs: _NFTs,
      gasDefault: defaultGasBudgetForTransferSUI,
    );
  }
}
