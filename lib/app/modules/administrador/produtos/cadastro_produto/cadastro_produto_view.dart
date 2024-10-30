import 'dart:io';

import 'package:boi_marronzinho/app/modules/administrador/produtos/cadastro_produto/cadastro_produto_controller.dart';
import 'package:boi_marronzinho/app/modules/componentes/ButtonBox.dart';
import 'package:boi_marronzinho/app/modules/componentes/buildAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class AddProdutoView extends GetView<AddProdutoController> {
  const AddProdutoView({Key? key}) : super(key: key);

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
              buildAppBar('assets/images/icons/mingcute_arrow-up-fill.png',
                  text: ''),
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
                              return imageProduto();
                            }),
                            Padding(
                              padding: EdgeInsets.all(6.0.r),
                              child: ButtonBox(
                                text: 'Adicionar Imagem',
                                function: controller.pickImage,
                                colortext: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Form(
                            key: controller.registerProdutoFormKey,
                            child: Column(
                              children: [
                                SizedBox(height: 22.h),
                                inputBox(
                                  'Nome',
                                  controller.nomeController,
                                  TextInputType.text,
                                  controller.validateText,
                                  'Ex: Camisa do Boi',
                                ),
                                SizedBox(height: 22.h),
                                inputBox(
                                    'Descrição',
                                    controller.descricaoController,
                                    TextInputType.text,
                                    controller.validateText,
                                    'Ex: Descrição do produto...'),
                                SizedBox(height: 22.h),
                                inputBox(
                                    'Preço em Boicoins',
                                    controller.precoBoicoinsController,
                                    TextInputType.number,
                                    controller.validateNumber,
                                    'Ex: 50',
                                    formato:
                                        FilteringTextInputFormatter.digitsOnly),
                                SizedBox(height: 22.h),
                                inputBox(
                                    'Preço em Reais',
                                    controller.precoRealController,
                                    TextInputType.numberWithOptions(
                                        decimal: true),
                                    controller.validateNumber,
                                    'Ex: 25.40',
                                    formato:
                                        FilteringTextInputFormatter.digitsOnly),
                                SizedBox(height: 22.h),
                                inputBox(
                                    'Quantidade em estoque',
                                    controller.quantidadeController,
                                    TextInputType.number,
                                    controller.validateNumber,
                                    'Ex: 36',
                                    formato:
                                        FilteringTextInputFormatter.digitsOnly),
                                SizedBox(height: 24.h),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: ButtonBox(
                            text: 'Adicionar Produto',
                            function: controller.onCadastroProduto,
                            colortext: Colors.black,
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

  Widget imageProduto() {
    return controller.image == null
        ? Container(
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
          )
        : Container(
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
}
