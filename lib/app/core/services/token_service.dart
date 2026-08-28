import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService extends GetxService {
  late final SharedPreferences _prefs;
  final AuthService _authService;

  TokenService(this._authService);

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveTokens(SignInResponse signInResponse) async {
    await _prefs.setString('accessToken', signInResponse.accessToken);
    await _prefs.setString('refreshToken', signInResponse.refreshToken);
  }

  Future<String?> getAccessToken() async {
    return _prefs.getString('accessToken');
  }

  Future<String?> getRefreshToken() async {
    return _prefs.getString('refreshToken');
  }

  Future<void> clearTokens() async {
    await _prefs.remove('accessToken');
    await _prefs.remove('refreshToken');
  }

  Future<String?> getToken() async {
    final accessToken = await getAccessToken();
    final isTokenExpiringSoon = _isTokenExpiringSoon(accessToken);

    if (accessToken != null && !isTokenExpiringSoon) {
      return accessToken;
    }
    final refreshToken = await getRefreshToken();

    if (refreshToken != null) {
      final request = RefreshTokenRequest(refreshToken: refreshToken);
      final isRefreshed = await _authService.refreshToken(request);

      if (isRefreshed) {
        return await getAccessToken();
      }
    }
    return null;
  }

  bool _isTokenExpiringSoon(String? token) {
    if (token == null) {
      return true;
    }

    try {
      final remaining = JwtDecoder.getRemainingTime(token);
      return remaining.inDays <= 3;
    } catch (e) {
      // print('Erro ao verificar expiração do token: $e'); // Para debug
      return true; // Trata como expirando em breve em caso de erro.
    }
  }
}
