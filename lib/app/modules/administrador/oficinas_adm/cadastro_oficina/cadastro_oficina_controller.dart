import 'dart:io';
import 'dart:convert';
import 'package:boi_marronzinho/app/data/util/url.dart';
import 'package:http/http.dart' as http;
import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/repositories/oficinas/oficinas_repository.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/oficinas_adm_module.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AddOficinaController extends BaseController {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController precoBoicoinsController = TextEditingController();
  final TextEditingController precoReaisController = TextEditingController();
  final TextEditingController participantesController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController ruaController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final GlobalKey<FormState> registerOficinaFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> endOficinaFormKey = GlobalKey<FormState>();

  Map<String, dynamic>? addressData;
  final ImagePicker _picker = ImagePicker();
  var address = ''.obs;
  var isLoading = false.obs;
  var selectDate = DateTime.now().obs;
  var _image = Rxn<File>();
  File? imagem;
  File? get image => _image.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
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

  Future<void> selectedDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2200));
    if (date != null && date != selectDate.value) {
      selectDate.value = date;
      dateController.text = "${date.day}/${date.month}/${date.year}";
    }
  }

  Future<void> onCadastroOficina() async {
    if (registerOficinaFormKey.currentState?.validate() ?? false) {
      setLoading(true);
      try {
        double precoBoicoins =
            double.tryParse(precoBoicoinsController.text) ?? 0.0;
        double precoReais = double.tryParse(precoReaisController.text) ?? 0.0;
        print(dateController.text);
        DateTime? parsedDate;
        try {
          parsedDate = DateFormat("dd/MM/yyyy").parse(dateController.text);
        } catch (e) {
          print("Formato de data inválido: ${dateController.text}");
          setLoading(false);
          return;
        }

        String isoDate = parsedDate.toUtc().toIso8601String();
        //String imageJson = await ImageData(_image, dadosRequest);
        print('-------------------------------');
        print('Imagem --->>>>>${_image.value!.path}');
        print(imagem);

        final registerOficina = await OficinasRepository().cadastrarOficina(
          nome: nomeController.text,
          descricao: descricaoController.text,
          precoBoicoins: precoBoicoins,
          precoReal: precoReais,
          dataOficina: isoDate, // Usar data no formato ISO 8601
          limiteOficina: int.tryParse(participantesController.text) ?? 20,
          imagem: imagem!,
          urlEndereco: enderecoController.text,
        );

        
        Get.back();
      } catch (e) {
        print("Erro ao cadastrar oficina: $e");
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
