import 'package:dio/dio.dart';
import 'package:shopping_app_example/src/core/network/dummy_client_options.dart';

final class DummyClient {
  final Dio _httpClient = Dio(DummyClientOptions());

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  }) async {
    final Response response = await _httpClient.get(
      url,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );

    return response;
  }
}
