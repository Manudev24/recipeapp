import 'package:recipeapp/services/auth/secure_storage.dart';

class AuthService {
  static Future<bool> isLogged() async {
    String? value = await SecureStorage.secureStorage.read(key: "token");
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  static void logOut() async {
    await SecureStorage.secureStorage.delete(key: "token");
  }
}
