import 'dart:convert';
import 'dart:io';

import 'package:boi_marronzinho/app/modules/administrador/eventos/editor_evento/editor_evento_controller.dart';
import 'package:boi_marronzinho/app/modules/componentes/AppBarClipper.dart';
import 'package:boi_marronzinho/app/modules/home_page/home_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class EditorEventoView extends GetView<EditorEventoController> {
  const EditorEventoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    File? _image;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
                               return imageEvento();
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
                            key: controller.editEventoFormKey, // Atualize a chave do formulário
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
                                inputBoxDate('Data do Evento', context,
                                    controller.dateController),
                              
                                SizedBox(height: 24.h),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: ButtonBox(
                            text: 'Salvar Alterações',
                            function: controller.onEditEvento, // Atualize a função de edição
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

   Widget imageEvento() {
     if (controller.image == null) {
       if (controller.evento.imagem.isEmpty) {
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
         return Container(
           width: 350.w,
           height: 200.h,
           decoration: BoxDecoration(
             shape: BoxShape.rectangle,
             borderRadius: BorderRadius.circular(16.0),
             image: DecorationImage(
               image: MemoryImage(base64Decode(controller.evento.imagem)), // Atualize para evento
               fit: BoxFit.cover,
             ),
           ),
         );
       }
     } else {
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
