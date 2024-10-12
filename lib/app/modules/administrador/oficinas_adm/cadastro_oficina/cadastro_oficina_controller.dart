import 'dart:io';

import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddOficinaController extends BaseController{
  
  final ImagePicker _picker = ImagePicker();
  var _image = Rxn<File>();
  File? get image => _image.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      _image.value = File(pickedFile.path);
    }
  }
  
  Future<void> onCadastroOficina() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      //_image = File(pickedFile.path);
    } else{
      _image.value = null;
    }
  }
  
}