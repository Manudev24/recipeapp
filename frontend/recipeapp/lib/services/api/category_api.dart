import 'package:dio/dio.dart';
import 'package:cookingenial/models/category_model.dart';
import 'package:cookingenial/utils/constans.dart';

class CategoryApi {
  static Future<List<CategoryModel>> getRandomCategories() async {
    // String? accessToken = await SecureStorage.secureStorage.read(key: "token");

    final dio = Dio(
        // BaseOptions(
        //   headers: {
        //     'Authorization': 'Bearer $accessToken',
        //     'Content-Type': 'application/json',
        //   },
        // ),
        );

    try {
      Response response = await dio.get('$apiUrl/randomCategories');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        List<CategoryModel> stores = data
            .map((item) => CategoryModel(
                  id: item['id'],
                  name: item['name'],
                  description: item['description'],
                ))
            .toList();
        return stores;
      } else {
        print(
            'Error - Status code: ${response.statusCode}, Message: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return [];
  }

  static Future<List<CategoryModel>> getAllCategories() async {
    // String? accessToken = await SecureStorage.secureStorage.read(key: "token");

    final dio = Dio(
        // BaseOptions(
        //   headers: {
        //     'Authorization': 'Bearer $accessToken',
        //     'Content-Type': 'application/json',
        //   },
        // ),
        );

    try {
      Response response = await dio.get('$apiUrl/allCategories');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        List<CategoryModel> stores = data
            .map((item) => CategoryModel(
                  id: item['id'],
                  name: item['name'],
                  description: item['description'],
                ))
            .toList();
        return stores;
      } else {
        print(
            'Error - Status code: ${response.statusCode}, Message: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return [];
  }
}
