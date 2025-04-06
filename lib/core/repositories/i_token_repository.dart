abstract class ITokenRepository {
  Future<String?> getAccessToken();
  Future<void> saveAccessToken(String token);
  Future<void> clearToken();
}