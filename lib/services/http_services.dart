import 'package:dio/dio.dart';

import '../models/product.dart';

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

  void saveForm(String endPoint, Product product) async {
    print(product.name);
    print(product.description);
    print(product.price);
    print(product.image);

    String fileName = product.image!.split('/').last;
    var data = FormData.fromMap({
      "name": product.name,
      "description": product.description,
      "price": product.price,
      "image": await MultipartFile.fromFile(product.image!, filename: fileName),
    });

    try {
      var response = await _dio!.post(endPoint, data: data);
    } on DioError {
      print('Ocurrio un error');
    }
  }
}
