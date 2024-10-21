import 'package:globipay_admin_panel/core/data/local/repository/token_repository.dart';
import 'package:globipay_admin_panel/core/utils/storage/app_secure_storage.dart';

/**
 * Created by Abdullah on 13/10/24.
 */

class TokenRepositoryImpl implements TokenRepository {
  final tokenKey = "TOKEN_KEY";
  final userKey = "USER_ID";

  AppSecureStorage storage;

  TokenRepositoryImpl(this.storage);

  @override
  Future<String> getToken() async {
    return await storage.read(
          key: tokenKey,
        ) ??
        '';
  }

  @override
  Future<void> saveToken(String token) async{
    await storage.write(
      key: tokenKey,
      value: token,
    );
  }

  @override
  Future<void> clearToken() async {
    return storage.delete(key: tokenKey);
  }

  @override
  Future<void> saveUserID(String userID) async {
    await storage.write(
      key: userKey,
      value: userID,
    );
  }

  @override
  Future<String> getUserID() async {
    return await storage.read(
      key: userKey,
    ) ??
        '';
  }
}
