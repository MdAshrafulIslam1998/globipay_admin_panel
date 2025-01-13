import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Created by Abdullah on 13/10/24.

class AppSecureStorage {
FlutterSecureStorage storage = const FlutterSecureStorage();

final authOption = const AndroidOptions(
    storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding);
Future<dynamic> read({key}) async {
  return await storage.read(key: key, aOptions: authOption);
}

Future<void> write({key, value}) async {
  await storage.write(key: key, value: value, aOptions: authOption);
}

void delete({key}) {
  storage.delete(key: key);
}
}