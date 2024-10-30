import 'package:boi_marronzinho/app/data/models/produto/produto.dart';
import 'package:boi_marronzinho/app/modules/administrador/produtos/produtos_controller.dart';
import 'package:boi_marronzinho/app/modules/componentes/AppBarClipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProdutosAdmView extends GetView<ProdutosAdmController> {
  const ProdutosAdmView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading == true) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.yellow,
                      ));
                  }
                  if (controller.produtos.isEmpty) {
                    return Center(
                      child: Text(
                        'Nenhum produto cadastrado.',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ));
                  }

                  return ListView.builder(
                    itemCount: controller.produtos.length,
                    itemBuilder: (context, index) {
                      final produto = controller.produtos[index];
                      
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h, 
                          horizontal: 16.w),
                        child: Box(context, produto.nome, produto), // Atualize aqui
                      );
                    },
                  );
                }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                child: ButtonBox(
                  text: 'Adicionar Produto', // Atualize o texto
                  onPressed: controller.onAddProdutosPressed, // Atualize a função
                ),
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
                            'Produtos ADM', // Atualize o título
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

  Widget Box(BuildContext context, String text, Produto produto) { // Atualize o tipo
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
                    controller.goToEditProduto(produto); // Atualize a função
                  },
                  icon: Icon(Icons.edit),
                  iconSize: 30.r,
                  color: Colors.black,
                ),
                IconButton(
                  onPressed: () {
                    controller.showDeleteConfirmationDialog(context, () async {
                      await controller.onDeleteProduto(produto); // Atualize a função
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
          padding: EdgeInsets.all(14.h),
        ),
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
