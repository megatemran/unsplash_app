import 'package:dio/dio.dart';

class HttpService {
  Dio? dio;

  final baseUrl = 'https://api.unsplash.com/';

  HttpService() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));
    initializeInterceptors();
  }

  // GET REQUEST
  Future<Response?> getRequest(String endpoint) async {
    try {
      Response response = await dio!.get(endpoint);
      print(response.data);
      print(response.headers);
      print(response.requestOptions);
      print(response.statusCode);
    } on DioError catch (e) {
      print(e.message);

      throw Exception(e.message);
    }
  }

  initializeInterceptors() {
    dio!.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent
      print("${options.method}  ${options.path}");

      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: `handler.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: `handler.reject(dioError)`
    }, onResponse: (response, handler) {
      // Do something with response data
      print(response.data);
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: `handler.reject(dioError)`
    }, onError: (DioError e, handler) {
      // Do something with response error
      print(e.message);
      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: `handler.resolve(response)`.
    }));
  }
}
