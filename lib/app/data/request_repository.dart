import 'package:boi_marronzinho/app/data/providers/bm_api_client/bm_api_client.provider.dart';
import 'package:boi_marronzinho/app/data/util/api/api_exception_handler.dart';
import 'package:boi_marronzinho/app/data/util/api/api_helpers.dart';
import 'package:boi_marronzinho/app/modules/home_page/home_page_module.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/get_connect/http/src/status/http_status.dart';


typedef ValidResponse<T> = ({bool valid, String? reason, T? data});

//TODO: onde tiver HomeModule.path substituir por LoginModule.path 

abstract base class RequestRepository {
  late ApiHelpers apiHelpers = ApiHelpers();
  late BmApiClient client = Get.find<BmApiClient>();

  bool _isNotLoginRoute() => Get.currentRoute != HomeModule.path;

    ValidResponse _unauthorizedResponse() {
    Get.offAllNamed(HomeModule.path);

    return (
      valid: false,
      data: null,
      reason: 'Acesso não autorizado, verifique suas permissões e tente novamente',
    );
  }

  ValidResponse<T> errorResponse<T>(dynamic error, {StackTrace? trace}) {
    if (error is DioException && _isNotLoginRoute() && (error.message ?? '').contains('status code of 401')) {
      return _unauthorizedResponse() as ValidResponse<T>;
    }

    if (kDebugMode) {
      if (trace != null) {
        print(error);
        print(trace);
      }

      return (valid: false, data: null, reason: error.toString());
    }

    return (valid: false, data: null, reason: 'Erro interno durante a requisição');
  }

  ValidResponse<T> isValidResponse<T>(Response response) {
    final statusCode = response.statusCode ?? 400;
    if (statusCode >= 200 && statusCode < 300) {
      return (valid: true, reason: null, data: null);
    }

    if (statusCode == HttpStatus.unauthorized && Get.currentRoute != HomeModule.path) {
      Get.offAllNamed(HomeModule.path);
      return (valid: false, reason: '401', data: null);
    }

    return (
    valid: false,
    data: null,
    reason: ApiExceptionHandler.handleError(statusCode, response.data),
    );
  }
}
