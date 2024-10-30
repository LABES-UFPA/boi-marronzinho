import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/enumerators/endpoints.enum.dart';
import 'package:boi_marronzinho/app/data/models/oficinas_response/oficinas_response.dart';
import 'package:boi_marronzinho/app/data/repositories/oficinas/oficinas_repository.dart';
import 'package:boi_marronzinho/app/data/util/api/api_helpers.dart';
import 'package:boi_marronzinho/app/global_ui/components/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditorOficinaController extends BaseController {
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
  final GlobalKey<FormState> editOficinaFormKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> endEditOficinaFormKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  late Oficina oficina;
  Map<String, dynamic>? addressData;
  var selectDate = DateTime.now().obs;
  var _image = Rxn<File>();
  File? get image => _image.value;
  File? imagem;
  var address = ''.obs;
  String link ='';
  String url = '';
  late ApiHelpers apiHelpers = ApiHelpers();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    oficina = Get.arguments as Oficina;
    nomeController.text = oficina.nomeOficina;
    descricaoController.text = oficina.descricao;
    precoBoicoinsController.text = oficina.precoBoicoin.toString();
    precoReaisController.text = oficina.precoReal.toString();
    participantesController.text = oficina.limiteParticipantes.toString();
    enderecoController.text = oficina.linkEndereco.toString();
    url = ApiHelpers().buildUrl(url: oficina.imagem, endpoint: Endpoints.MINIO);
    print('url ----->>>>>> ${url}');
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
      dateController.text = "${date.day}/${date.month}/${date.year}";
    }
  }

  Future<void> onEditarOficina() async {
  if (editOficinaFormKey2.currentState?.validate() ?? false) {
    setLoading(true);
    try {
      double precoBoicoins = double.tryParse(precoBoicoinsController.text) ?? 0.0;
      double precoReais = double.tryParse(precoReaisController.text) ?? 0.0;

      DateTime? parsedDate;
      enderecoController.text = link;
      try {
        // Converte a data do formato "dd/MM/yyyy" para DateTime
        parsedDate = DateFormat("dd/MM/yyyy").parse(dateController.text);
        print(dateController.text);
      } catch (e) {
        print("Formato de data inválido: ${dateController.text}");
        Toast.error(
          'Formato de data inválido',
          'Por favor, insira a data no formato correto (dd/MM/yyyy).',
          delayed: true,
        );
        setLoading(false);
        return;
      }

      String isoDate = parsedDate.toUtc().toIso8601String();
      

      // Crie a requisição de atualização com campos opcionais
      final editarOficina = await OficinasRepository().editarOficina(
        id: oficina.id, // Inclua o ID da oficina para identificar qual será atualizada
        nome: nomeController.text.isNotEmpty ? nomeController.text : null,
        descricao: descricaoController.text.isNotEmpty ? descricaoController.text : null,
        precoBoicoins: precoBoicoins > 0 ? precoBoicoins : null,
        precoReal: precoReais > 0 ? precoReais : null,
        dataOficina: isoDate,
        limiteOficina: int.tryParse(participantesController.text) ?? null,
        imagem: imagem ?? null,
        urlEndereco: enderecoController.text.isNotEmpty ? enderecoController.text : null,
      );

      // Verifique se a edição foi bem-sucedida
      if (editarOficina.valid) {
        Toast.success(
          'Oficina editada com sucesso!',
          'As informações da oficina foram atualizadas.',
          delayed: true,
        );
        Get.back();
      } else {
        Toast.error(
          'Falha ao editar oficina',
          editarOficina.reason ?? 'Erro desconhecido.',
          delayed: true,
        );
      }
    } catch (e) {
      print("Erro ao editar oficina: $e");
      Toast.error(
        'Falha ao editar oficina',
        e.toString(),
        delayed: true,
      );
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
        link = await getGoogleMapsLinkFromAddress();
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
