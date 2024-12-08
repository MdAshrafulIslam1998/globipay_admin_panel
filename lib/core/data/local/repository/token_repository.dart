/**
 * Created by Abdullah on 13/10/24.
 */

abstract class TokenRepository {
  Future<void> saveToken(String token);
  Future<String> getToken();
  Future<void> clearToken();
  Future<void> saveUserID(String userID);
  Future<String> getUserID();
  Future<void> saveRole(String role);
  Future<String> getRole();

  Future<void> saveStuffId(String id);
  Future<String> getStuffId();

}