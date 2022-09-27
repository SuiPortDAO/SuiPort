import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SafeStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<Map<String, String>> readAll() async {
    return await _storage.readAll(
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }

  Future<Map<String, String>> deleteAll() async {
    await _storage.deleteAll(
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    return readAll();
  }

  Future<Map<String, String>> write(key, value) async {
    await _storage.write(
      key: key,
      value: value,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    return readAll();
  }

  IOSOptions _getIOSOptions() => const IOSOptions(
        // TODO
        // add user acount
        accountName: null,
      );

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
}
