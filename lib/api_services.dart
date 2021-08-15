import 'package:dio/dio.dart';
import 'package:unsplash_app/unsplash_model.dart';

class APIServices {
  static String apiKey = 'K9fzIEZA9C4Cu6z4hqE9c6x0MRsQyju4cs8LzX7QhKk';
  static String query = 'burger';
  String url =
      'https://api.unsplash.com/search/photos?page=1&query=office&client_id=$apiKey';

  Dio? dio;

  APIServices() {
    dio = Dio();
  }

  Future<List<Result>?> fetctAPI() async {
    try {
      Response response = await dio!.get(url);
      Welcome imageResponse = Welcome.fromJson(response.data);
      return imageResponse.results;
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
