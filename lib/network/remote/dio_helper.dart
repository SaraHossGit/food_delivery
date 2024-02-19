import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://www.themealdb.com/api/json/v1/1/",
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> dioGetQuisinesList() async {
    late Response response;
    response = await dio.get(
      '/list.php?a=list',
    );
    return response;
  }

  static Future<Response> dioGetMealsList({
    required String quisineName,
  }) async {
    late Response response;
    response = await dio.get(
      '/filter.php',
      queryParameters: {'a': quisineName},
    );
    return response;
  }

  static Future<Response> dioGetFilteredMealsList({
    required String filter,
  }) async {
    late Response response;
    response = await dio.get(
      '/filter.php',
      queryParameters: {'c': filter},
    );
    return response;
  }

  static Future<Response> dioGetRandomMeal() async {
    print("here random");
    late Response response;
    response = await dio.get(
      '/random.php',
    );
    return response;
  }
}
