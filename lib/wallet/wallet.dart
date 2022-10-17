import 'package:wallet/wallet/sui/sui_wallet.dart';

abstract class Chain {
  late String name;
}

abstract class Wallet {
  String getName();
  Future<Map<String, num>> getBalance();
  Future<num> getPrimaryCoinBalance();
  List<Chain> getChains();
  Future<String> getPublicAddress();
  Future<void> initWallet();
  Future<void> updateWallet();
  Future<bool> transfer(String recipient, int amount, String coinType);
  Future<List> getTransactions();
  Future<List> getNFTs();
  Future<bool> executeMoveCall(MoveCallTransaction transaction);
}
