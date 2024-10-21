import 'package:boi_marronzinho/app/data/repositories/meus_dados/meus_dados_repository.interface.dart';
import 'package:boi_marronzinho/app/data/request_repository.dart';
import 'dart:developer';


final class MeusDadosRepository extends RequestRepository implements IMeusDadosRepository {
  static const String userdataURL = "/api/v1/usuarios";

  @override
  Future<dynamic> fetchUserData() async {
    final url = apiHelpers.buildUrl(url: userdataURL);

    try {
      final response = client.get(url);
    }
    catch (e, stackTrace) {
      log('Error fetching user data', error: e, stackTrace: stackTrace);
      return (valid: false, reason: 'Erro interno durante a requisição', data: null);
    }
  }

}