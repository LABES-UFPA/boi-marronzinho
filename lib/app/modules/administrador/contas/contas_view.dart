import 'dart:convert';
import 'dart:typed_data';

import 'package:boi_marronzinho/app/data/models/profile/profile.dart';
import 'package:boi_marronzinho/app/data/models/user_permission/user_permission.dart';
import 'package:boi_marronzinho/app/modules/administrador/contas/contas_controller.dart';
import 'package:boi_marronzinho/app/modules/home_page/sobre_nos/sobre_nos_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContasView extends GetView<ContasController> {
  const ContasView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: [
              _buildAppBar(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: searchMenu(controller.searchController),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading == true) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.yellow,
                    )); // Mostra um loading.
                  }
                  if (controller.contas.isEmpty) {
                    return Center(
                        child: Text(
                      'Nenhuma conta cadastrada.',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ));
                  }

                  return ListView.builder(
                    itemCount: controller.contas.length,
                    itemBuilder: (context, index) {
                      final conta = controller.contas[index];

                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 16.w),
                        child: Box(context, '${conta.firstName} ${conta.lastName}', conta),
                      );
                    },
                  );
                }),
              ),
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
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10.w),
                        Center(
                          child: Text(
                            'Contas ADM',
                            style: TextStyle(
                              fontSize: 36.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget Box(BuildContext context, text, UserPermission conta) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  width: 240.w,
                  child: Text(
                    text,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.goToEditConta(conta);
                  },
                  icon: Icon(Icons.edit),
                  iconSize: 30.r,
                  color: Colors.black,
                ),
                IconButton(
                  onPressed: () {
                    controller.showDeleteConfirmationDialog(context, () async {
                      await controller.onDeleteConta(conta);
                    });
                  },
                  icon: Icon(Icons.delete),
                  iconSize: 30.r,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget searchMenu(TextEditingController searchController) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 8), // Espaçamento entre o ícone e o campo de texto
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Buscar...',
                border: InputBorder.none,
              ),
              onChanged: (value) {
                // Lógica para filtrar resultados, se necessário
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonBox extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  ButtonBox({required this.text, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
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
            fontWeight: FontWeight.bold, // Deixar o texto em negrito
            color: Colors.black, // Cor do texto (preto)
          ),
        ),
      ),
    );
  }
}
