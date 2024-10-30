import 'dart:io';

import 'package:boi_marronzinho/app/modules/administrador/item_troca/cadastro_item/cadastro_item_controller.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/editor_oficina/editor_oficina_view.dart';
import 'package:boi_marronzinho/app/modules/componentes/AppBarClipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class AddItemView extends GetView<AddItemController> {
  const AddItemView({Key? key}) : super(key: key);

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
              _buildAppBar(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        
                        Form(
                          key: controller.registerItemFormKey,
                          child: Column(
                            children: [
                              SizedBox(height: 22.h),
                              inputBox(
                                'Nome',
                                controller.nomeController,
                                TextInputType.text,
                                controller.validateText,
                                'Ex: Óleo',
                              ),
                              SizedBox(height: 22.h),
                              inputBox(
                                'Descrição',
                                controller.descricaoController,
                                TextInputType.text,
                                controller.validateText,
                                'Ex: Óleo usado...',
                              ),
                              SizedBox(height: 22.h),
                              dropBox('Unidade de Medida', controller.unidadeController, controller.selectedOption),
                              SizedBox(height: 22.h),
                              inputBox(
                                    'Boicoins por unidade',
                                    controller.boicoinsController,
                                    TextInputType.number,
                                    controller.validateBoicoins,
                                    'Ex: 25',
                                    formato:
                                        FilteringTextInputFormatter.digitsOnly),
                              SizedBox(height: 24.h),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: ButtonBox(
                            text: 'Adicionar Item',
                            function: controller.onCadastroItem,
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

  Widget _buildAppBar() {
    return Stack(
      children: [
        ClipPath(
          clipper: AppBarClipper(),
          child: Container(
            height: 100.h,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10).h,
              child: Row(
                children: [
                  IconButton(
                    icon: Image.asset(
                      'assets/images/icons/mingcute_arrow-up-fill.png',
                      height: 40.h,
                      width: 40.w,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget inputBox(String text, TextEditingController controller,
      TextInputType type, String? Function(String?) validation, String hint,
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
                hintText: hint,
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
      DropdownMenuItem(value: 'MILILITRO', child: Text('ml')),
      DropdownMenuItem(value: 'UNIDADE', child: Text('Unidade')),
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
