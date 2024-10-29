import 'dart:convert';

import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/util/url.dart';
import 'package:http/http.dart' as http;
class LocalizarController extends BaseController {
  var address = '';
  Map<String, dynamic>? addressData;
  String cep = '66077110';
  String rua = 'Passagem Brasília';
  String numero = '170';
  String link = '';
  @override
  void onInit() {
    super.onInit();
    //fetchAddressFromCEP(cep);
  }
  Future<void> fetchAddressFromCEP(cep) async {  
    try {
      isLoading.value = true;
      final response =
          await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));

      if (response.statusCode == 200) {
        addressData = jsonDecode(response.body); // Armazena a resposta

        if (addressData!.containsKey('erro')) {
          throw Exception('CEP não encontrado');
        }

        address = addressData!['logradouro'] ?? 'Endereço não encontrado';
        link = await getGoogleMapsLinkFromAddress();
      } else {
        throw Exception('Erro ao buscar o endereço');
      }
    } catch (e) {
      address = 'Erro ao buscar endereço: $e';
    } finally {
      isLoading.value = false; // Termina o estado de carregamento
    }
  }

  Future<String> getGoogleMapsLinkFromAddress() async {
    String street = rua.trim(); // O nome da rua inserido
    String number = numero.trim(); // O número da residência digitado
    String neighborhood =
        addressData?['bairro'] ?? ''; // Pega o bairro, se disponível
    String city = addressData?['localidade'] ?? ''; // Pega a cidade
    String state = addressData?['uf'] ?? ''; // Pega o estado
    String country = 'Brasil'; // Você pode definir o país, se necessário

    if (street.isNotEmpty && number.isNotEmpty) {
      String query = Uri.encodeComponent(
          '$street, $number, $neighborhood, $city, $state, $country');
      return 'https://www.google.com/maps/search/?api=1&query=$query';
    } else {
      throw 'Endereço ou número inválido';
    }
  }

  Future<void> onVerLocationPressed() async {
    await fetchAddressFromCEP(cep); // Aguarda a conclusão da busca do CEP
    if (link.isNotEmpty) {
      OpenUrl.openGoogleMaps(link);
    } else {
      print('Link vazio, verifique o CEP e tente novamente.');
    }
  }
}
