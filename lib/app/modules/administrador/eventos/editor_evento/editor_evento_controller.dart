import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/evento/evento.dart';
import 'package:boi_marronzinho/app/data/repositories/evento/evento_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditorEventoController extends BaseController {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController precoBoicoinsController = TextEditingController();
  final TextEditingController precoReaisController = TextEditingController();
  final TextEditingController participantesController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController ruaController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final GlobalKey<FormState> editEventoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> endEditEventoFormKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  late Evento evento;  // Altere para Evento
  var selectDate = DateTime.now().obs;
  File? imagem;
  Map<String, dynamic>? addressData;
  var address = ''.obs;
  var _image = Rxn<File>();
  var _imageCarregda = Rxn<File>();
  File? get image => _image.value;

  @override
  void onInit() {
    super.onInit();
    evento = Get.arguments as Evento; // Altere para Evento
    nomeController.text = evento.nome; // Altere para nomeEvento
    descricaoController.text = evento.descricao; 
  }
  
  String? validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo Obrigatório';
    }
    return null;
  }

  String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo Obrigatório';
    }
    final price = double.tryParse(value);
    if (price == null || price <= 0) {
      return 'Preço inválido';
    }
    return null;
  }

  String? validateParticipants(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo Obrigatório';
    }
    final participants = int.tryParse(value);
    if (participants == null || participants <= 0) {
      return 'Quantidade inválida';
    }
    return null;
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image.value = File(pickedFile.path);
      imagem = File(pickedFile.path);
    }
  }

  Uint8List? base64ToImage(String base64String) {
    try {
      return Base64Decoder().convert(base64String);
    } catch (e) {
      print('Erro ao decodificar a imagem: $e');
      return null; // Retorna null em caso de erro
    }
  }

  Future<void> selectedDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2200));
    if (date != null && date != selectDate.value) {
      selectDate.value = date;
    }
  }

  Future<void> onEditEvento() async {
  if (editEventoFormKey.currentState?.validate() ?? false) {
    setLoading(true);
    try {
      final registerEvento = await EventosRepository().editarEvento(
        id: evento.id,
        nome: nomeController.text,
        descricao: descricaoController.text,
        dataEvento: dateController.text,
        imagem: imagem!,
        urlEndereco: enderecoController.text, 
      );

   
      if (registerEvento.valid) {
        Get.back(); 
      } else {
      }
    } catch (e) {
    } finally {
      setLoading(false); 
    }
  }
}
Future<void> fetchAddressFromCEP(String cep) async {
    try {
      isLoading.value = true;
      final response =
          await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));

      if (response.statusCode == 200) {
        addressData = jsonDecode(response.body); // Armazena a resposta

        if (addressData!.containsKey('erro')) {
          throw Exception('CEP não encontrado');
        }

        address.value = addressData!['logradouro'] ?? 'Endereço não encontrado';
        enderecoController.text = await getGoogleMapsLinkFromAddress();
      } else {
        throw Exception('Erro ao buscar o endereço');
      }
    } catch (e) {
      address.value = 'Erro ao buscar endereço: $e';
    } finally {
      isLoading.value = false; // Termina o estado de carregamento
    }
  }
  Future<String> getGoogleMapsLinkFromAddress() async {
    String street = ruaController.text.trim(); // O nome da rua inserido
    String number =
        numberController.text.trim(); // O número da residência digitado
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

}
