import 'dart:convert';
import 'dart:io';

import 'package:boi_marronzinho/app/data/enumerators/endpoints.enum.dart';
import 'package:boi_marronzinho/app/data/util/api/api_helpers.dart';
import 'package:boi_marronzinho/app/modules/administrador/produtos/editor_produto/editor_produto_controller.dart';
import 'package:boi_marronzinho/app/modules/componentes/AppBarClipper.dart';
import 'package:boi_marronzinho/app/modules/componentes/ButtonBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditorProdutoView extends GetView<EditorProdutoController> {
  const EditorProdutoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                              return imageProduto();
                            }),
                            Padding(
                              padding: EdgeInsets.all(6.0.r),
                              child: ButtonBox(
                                text: 'Alterar Imagem',
                                function: controller.pickImage,
                                colortext: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Form(
                          key: controller.editProdutoFormKey,
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
                              SizedBox(height: 24.h),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(vertical: 16.h),
                        //   child: ButtonBox(
                        //     text: 'Salvar Alterações',
                        //     function: controller.onEditProduto, // Atualize a função de edição
                        //   ),
                        // ),
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

  Widget imageProduto() {
  // Verifica se a imagem local (File) é nula
  if (controller.image == null) {
    // Se a imagem local for nula, verifica se a imagem Base64 está disponível
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        width: 350.w,
        height: 160.h,
        child: Image.network(
          ApiHelpers().buildUrl(
            url: controller.produto.imagemURL,
            endpoint: Endpoints.MINIO,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
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
                errorStyle: TextStyle(fontSize: 14.sp, overflow: TextOverflow.ellipsis),
              ),
              validator: (value) => validation(value),
            ),
          ],
        ),
      ),
    );
  }

  
}
