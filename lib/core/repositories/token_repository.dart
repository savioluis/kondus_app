import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kondus/core/repositories/i_token_repository.dart';

class TokenRepository implements ITokenRepository {
  TokenRepository({required FlutterSecureStorage storage}) : _storage = storage;

  final FlutterSecureStorage _storage;

  static const _accessTokenKey = 'access_token';

  @override
  Future<String?> getAccessToken() async {
    return _storage.read(key: _accessTokenKey);
  }

  @override
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  @override
  Future<void> clearToken() async {
    await _storage.delete(key: _accessTokenKey);
  }
}
