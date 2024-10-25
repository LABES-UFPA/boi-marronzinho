import 'dart:io';

import 'package:boi_marronzinho/app/modules/administrador/contas/editor_contas/editor_contas_controller.dart';
import 'package:boi_marronzinho/app/modules/componentes/buildAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class EditorContaView extends GetView<EditorContaController> {
  const EditorContaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    File? _image;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: [
              buildAppBar('assets/images/icons/mingcute_arrow-up-fill.png', text: ''),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Form(
                            key: controller.editContaFormKey,
                            child: Column(
                              children: [
                                SizedBox(height: 22.h),
                                inputBox(
                                    'Nome',
                                    controller.firstNameController,
                                    TextInputType.text,
                                    controller.validateText),
                                SizedBox(height: 22.h),
                                inputBox(
                                    'Sobrenome',
                                    controller.lastNameController,
                                    TextInputType.text,
                                    controller.validateText),
                                SizedBox(height: 22.h),
                                dropBox(
                                    'Permissão de usuário',
                                    controller.tipoUsuarioController,
                                    controller.selectedOption),
                                SizedBox(height: 24.h),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: ButtonBox(
                            text: 'Salvar Alterações',
                            function: controller.onEditConta,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  

  Widget inputBox(String text, TextEditingController controller,
      TextInputType type, String? Function(String?) validation,
      {TextInputFormatter? formato}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 0.8.h),
            ),
            TextFormField(
              controller: controller,
              keyboardType: type,
              inputFormatters: formato != null
                  ? <TextInputFormatter>[formato]
                  : <TextInputFormatter>[],
              decoration: InputDecoration(
                hintText: controller.text,
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                errorStyle:
                    TextStyle(fontSize: 14.sp, overflow: TextOverflow.ellipsis),
              ),
              validator: (value) => validation(value),
            ),
          ],
        ),
      ),
    );
  }

  Widget dropBox(
      String text, TextEditingController controller, RxString selectedOption) {
    final List<DropdownMenuItem<String>> items = [
      DropdownMenuItem(value: 'Usuario', child: Text('Usuário')),
      DropdownMenuItem(value: 'Administrador', child: Text('Administrador')),
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Obx(() {
              return DropdownButtonFormField<String>(
                value: selectedOption.value.isNotEmpty
                    ? selectedOption.value
                    : null, // Se o valor não estiver vazio, exibe o valor
                items: items,
                onChanged: (value) {
                  selectedOption.value =
                      value ?? ''; // Atualiza a variável observável
                  controller.text =
                      value ?? ''; // Atualiza o controller, se necessário
                },
                decoration: InputDecoration(
                  hintText: 'Selecione permissão',
                  border: InputBorder.none,
                  errorStyle: TextStyle(fontSize: 14),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }


  
}

class ButtonBox extends StatelessWidget {
  final String text;
  final Future<void> Function() function;

  ButtonBox({required this.text, required this.function});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFF69302),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
                topLeft: Radius.circular(20.r),
              ),
            ),
            padding: EdgeInsets.all(14.h)),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
