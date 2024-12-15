import 'package:dio/dio.dart';

final class DummyClientOptions extends BaseOptions {
  DummyClientOptions() {
    baseUrl = 'https://dummyjson.com/';
    connectTimeout = const Duration(seconds: 5);
    receiveTimeout = const Duration(seconds: 5);
    headers = {
      'Content-Type': 'application/json',
    };
    responseType = ResponseType.json;
  }
}
