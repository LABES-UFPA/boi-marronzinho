import 'dart:convert';
import 'dart:io';

import 'package:boi_marronzinho/app/data/models/oficinas_response/oficinas_response.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/editor_oficina/editor_oficina_controller.dart';
import 'package:boi_marronzinho/app/modules/home_page/home_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class EditorOficinaView extends GetView<EditorOficinaController> {
  const EditorOficinaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    File? _image;
    final oficina = Get.arguments as Oficina;
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
                        Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Obx(() {
                              return imageOficina();
                            }),
                            Padding(
                              padding: EdgeInsets.all(6.0.r),
                              child: ButtonBox(
                                text: 'Alterar Imagem',
                                function: controller.pickImage,
                              ),
                            ),
                          ],
                        ),
                        Form(
                            key: controller.editOficinaFormKey2,
                            child: Column(
                              children: [
                                SizedBox(height: 22.h),
                                inputBox(
                                    'Nome',
                                    controller.nomeController,
                                    TextInputType.text,
                                    controller.validateText),
                                SizedBox(height: 22.h),
                                inputBox(
                                    'Descrição',
                                    controller.descricaoController,
                                    TextInputType.text,
                                    controller.validateText),
                                SizedBox(height: 22.h),
                                inputBox(
                                    'Preço em Boicoins',
                                    controller.precoBoicoinsController,
                                    TextInputType.number,
                                    controller.validateNumber,
                                    formato:
                                        FilteringTextInputFormatter.digitsOnly),
                                SizedBox(height: 22.h),
                                inputBox(
                                    'Preço em Reais',
                                    controller.precoReaisController,
                                    TextInputType.numberWithOptions(
                                        decimal: true),
                                    controller.validateNumber,
                                    formato:
                                        FilteringTextInputFormatter.digitsOnly),
                                SizedBox(height: 22.h),
                                inputBoxDate('Data da Oficina', context,
                                    controller.dateController),
                                SizedBox(height: 22.h),
                                inputBox(
                                    'Limite de Participantes',
                                    controller.participantesController,
                                    TextInputType.number,
                                    controller.validateNumber,
                                    formato:
                                        FilteringTextInputFormatter.digitsOnly),
                                SizedBox(height: 24.h),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: ButtonBox(
                            text: 'Salvar Alterações',
                            function: controller.onEditOficina,
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

  Widget imageOficina() {
    // Verifica se a imagem local (File) é nula
    if (controller.image == null) {
      // Se a imagem local for nula, verifica se a imagem Base64 está disponível
      if (controller.oficina.imagem.isEmpty) {
        // Se a imagem Base64 também estiver vazia, exibe o ícone
        return Container(
          width: 350.w,
          height: 160.h,
          child: Icon(
            Icons.image,
            size: 50,
            color: Colors.white,
          ),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 206, 206, 206),
            borderRadius: BorderRadius.circular(16.0),
          ),
        );
      } else {
        // Se a imagem Base64 estiver disponível, a exibe
        return Container(
          width: 350.w,
          height: 200.h,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16.0),
            image: DecorationImage(
              image: MemoryImage(base64Decode(controller.oficina.imagem)),
              fit: BoxFit.cover,
            ),
          ),
        );
      }
    } else {
      // Se a imagem local não for nula, a exibe
      return Container(
        width: 350.w,
        height: 200.h,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
            image: FileImage(controller.image!),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
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

  Widget inputBoxDate(
      String text, BuildContext context, TextEditingController controllerText) {
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
            Obx(() => TextFormField(
                  controller: controllerText,
                  decoration: InputDecoration(
                    hintText:
                        "${controller.selectDate.value.day}/${controller.selectDate.value.month}/${controller.selectDate.value.year}",
                    border: InputBorder.none,
                    errorStyle: TextStyle(
                        fontSize: 14.sp, overflow: TextOverflow.ellipsis),
                  ),
                  onTap: () {
                    controller.selectedDate(context);
                  },
                )),
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
