import 'dart:io';

import 'package:boi_marronzinho/app/modules/administrador/eventos/cadastro_evento/cadastro_evento_controller.dart';
import 'package:boi_marronzinho/app/modules/componentes/buildAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class AddEventoView extends GetView<AddEventoController> {
  const AddEventoView({Key? key}) : super(key: key);

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
              buildAppBar('assets/images/icons/mingcute_arrow-up-fill.png', text: ''),
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
                                text: 'Adicionar Imagem',
                                function: controller.pickImage,
                              ),
                            ),
                          ],
                        ),
                        Form(
                            key: controller.registerEventoFormKey,
                            child: Column(
                              children: [
                                SizedBox(height: 22.h),
                                inputBox(
                                  'Nome',
                                  controller.nomeController,
                                  TextInputType.text,
                                  controller.validateText,
                                  'Ex: Festival de Cultura',
                                ),
                                SizedBox(height: 22.h),
                                inputBox(
                                    'Descrição',
                                    controller.descricaoController,
                                    TextInputType.text,
                                    controller.validateText,
                                    'Ex: Junte-se a nós para...'),
                                SizedBox(height: 22.h),
                                inputBoxDate('Data da Evento', context,
                                    controller.dateController),
                                SizedBox(
                                  height: 20.h,
                                ),
                                inputBoxMap('Localização', context),
                                SizedBox(height: 24.h),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: ButtonBox(
                            text: 'Adicionar Evento',
                            function: controller.onCadastroEvento,
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


  Widget imageEvento() {
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
                  //keyboardType: type,
                  decoration: InputDecoration(
                    hintText:
                        "${controller.selectDate.value.day}/${controller.selectDate.value.month}/${controller.selectDate.value.year}",
                    hintStyle:
                        TextStyle(color: const Color.fromARGB(255, 88, 88, 88)),
                    border: InputBorder.none,
                    errorStyle: TextStyle(
                        fontSize: 14.sp, overflow: TextOverflow.ellipsis),
                  ),
                  onTap: () {
                    controller.selectedDate(context);
                    
                  },
                  //validator: (value) => validation(value),
                )),
          ],
        ),
      ),
    );
  }

  Widget inputBoxMap(
    String text,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return buildCard(context);
            });
      },
      child: Container(
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
              Obx(() {
                return !controller.isLoading.value &&
                        controller.address.value.isNotEmpty &&
                        controller.ruaController.text.isNotEmpty &&
                        controller.numberController.text.isNotEmpty
                    ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8).h,
                      child: Text(
                          '${controller.address.value} ${controller.ruaController.text} ${controller.numberController.text}'),
                    )
                    : SizedBox.shrink();
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16).r,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: controller.endEventoFormKey,
                child: Column(
                  children: [
                    TextFormField(
                        controller: controller.cepController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Digite o CEP',
                          errorStyle: TextStyle(
                              fontSize: 14.sp, overflow: TextOverflow.ellipsis),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters:
                            FilteringTextInputFormatter.digitsOnly != null
                                ? <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ]
                                : <TextInputFormatter>[],
                        validator: (value) => value == null || value.isEmpty
                            ? 'Por favor, insira o CEP'
                            : null),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: controller.ruaController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Digite o nome da rua',
                        errorStyle: TextStyle(
                            fontSize: 14.sp, overflow: TextOverflow.ellipsis),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Por favor, insira o nome da rua'
                          : null,
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: controller.numberController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Digite o número do endereço',
                        errorStyle: TextStyle(
                            fontSize: 14.sp, overflow: TextOverflow.ellipsis),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters:
                          FilteringTextInputFormatter.digitsOnly != null
                              ? <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ]
                              : <TextInputFormatter>[],
                      validator: (value) => value == null || value.isEmpty
                          ? 'Por favor, insira o número do endereço'
                          : null,
                    ),
                    SizedBox(height: 16.h),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF69302),
                        ),
                        onPressed: () {
                          if (controller.endEventoFormKey.currentState
                                  ?.validate() ??
                              false) {
                            String cep = controller.cepController.text;
                            controller.fetchAddressFromCEP(cep);
                            Get.back();
                          }
                        },
                        child: Text(
                          'Adicionar Endereço',
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
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
