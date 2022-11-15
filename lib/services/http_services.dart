import 'package:dio/dio.dart';

class HttpServices {
  Dio? _dio;

  final _baseUrl = 'http://10.0.2.2:8000';

  HttpServices() {
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
  }

  void getResquest(String edpoint) async {
    Response? response;
    try {
      response = await _dio?.get(edpoint);
      print(response?.data);
    } on DioError {
      print('Errorrrrrrr');
    }
  }
}
