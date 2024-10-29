import 'package:boi_marronzinho/app/data/models/user_permissions/user_permission.dart';
import 'package:boi_marronzinho/app/modules/administrador/contas/contas_controller.dart';
import 'package:boi_marronzinho/app/modules/componentes/AppBarClipper.dart';
import 'package:boi_marronzinho/app/modules/componentes/buildAppBar.dart';
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
              buildAppBar('assets/images/icons/mingcute_arrow-up-fill.png', text: 'Contas ADM'),
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
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Buscar...',
                border: InputBorder.none,
              ),
              onChanged: (value) {
                controller.filterContas();
              },
            ),
          ),
        ],
      ),
    );
  }
}

