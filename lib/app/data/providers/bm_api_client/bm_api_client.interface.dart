import 'package:dio/dio.dart';

abstract interface class IBmApiClient {
  Future<Response> get(
      String url, {
        Map<String, dynamic> headers = const {},
      });

  Future<Response> post(
      String url,
      String body, {
        Map<String, dynamic> headers = const {},
      });

  Future<Response> put(
      String url,
      String body, {
        Map<String, dynamic> headers = const {},
      });

  Future<Response> postParams(String url, Map<String, dynamic> queryParams, {Map<String, dynamic> headers});

  Future<Response> postMultipart(
    String url,
    File file, {
    String fieldName = 'file',
    Map<String, dynamic> additionalData = const {},
    Map<String, dynamic> headers = const {},
  });
}
