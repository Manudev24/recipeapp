import 'package:dio/dio.dart';
import 'package:recipeapp/models/user_model.dart';
import 'package:recipeapp/services/auth/auth_service.dart';
import 'package:recipeapp/services/auth/secure_storage.dart';
import 'package:recipeapp/utils/constans.dart';

class UserApi {
  static Future<String?> loginUser(
    String userName,
    String password,
  ) async {
    final dio = Dio();

    final dataToSend = {
      'userName': userName,
      'password': password,
    };

    try {
      Response response = await dio.post('${apiUrl}/login', data: dataToSend);

      if (response.statusCode == 200) {
        String token = response.data['token'] as String;
        return token;
      } else {
        print(
            'Error - Status code: ${response.statusCode}, Message: ${response.statusMessage}');
      }
      return null;
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<UserModel?> loadUser() async {
    String? accessToken = await SecureStorage.secureStorage.read(key: "token");

    final dio = Dio(
      BaseOptions(
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      ),
    );

    try {
      Response response = await dio.post('${apiUrl}/loadData');

      if (response.statusCode == 200) {
        return UserModel(
          id: response.data['id'],
          firstName: response.data['firstName'],
          lastName: response.data['lastName'],
          userName: response.data['userName'],
          membership: response.data['membership'],
        );
      } else {
        AuthService.logOut();
        print(
            'Error - Status code: ${response.statusCode}, Message: ${response.statusMessage}');
      }
    } catch (e) {
      AuthService.logOut();
      print('Error: $e');
    }
    return null;
  }
}
