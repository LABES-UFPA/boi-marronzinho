import 'package:boi_marronzinho/app/modules/home_page/sobre_nos/sobre_nos_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../componentes/AppBarClipper.dart';

class SobreNosView extends GetView<SobreNosController> {
  const SobreNosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFB12623),
        body: Column(
          children: [
            Stack(
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
                                Icon(
                                  Icons.info,
                                  color: Colors.black,
                                  size: 30.sp,
                                ),
                                SizedBox(width: 5.w),
                                Center(
                                  child: Text(
                                    'Sobre Nós',
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
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 2.0.h),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo/logo_boi_marronzinho.png",
                    width: 200.0.w,
                    height: 275.0.h,
                  ),
                  Text(
                    'O Boi Marronzinho é uma associação cultural vibrante '
                    'localizada na região amazônica, mais especificamente '
                    'no bairro da Terra Firme em Belém do Pará. Essa associação '
                    'tem um papel crucial na comunidade, oferecendo uma '
                    'variedade de serviços e atividades que ajudam a melhorar '
                    'a qualidade de vida das pessoas locais.\n\n'
                    'Uma das principais iniciativas do Boi Marronzinho são '
                    'as oficinas culturais, que proporcionam oportunidades '
                    'para os moradores aprenderem sobre as tradições e artes '
                    'da região. Essas oficinas abrangem desde danças folclóricas '
                    'até artesanato tradicional, incentivando o orgulho cultural '
                    'e a preservação das raízes amazônicas.\n\n'
                    'Além das oficinas, o Boi Marronzinho também promove a venda '
                    'de produtos artesanais feitos pelos próprios membros da '
                    'comunidade. Essa atividade não apenas gera renda para os '
                    'artesãos locais, mas também valoriza as habilidades e '
                    'técnicas tradicionais de produção, ajudando a manter viva '
                    'a herança cultural da região.\n\n'
                    'Outro importante papel do Boi Marronzinho é o apoio a eventos '
                    'e celebrações culturais no bairro da Terra Firme e em toda Belém.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      height: 1.5.sp,
                    ),
                  ),
                  SizedBox(height: 34.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Rede de Parceiros: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    '- Coletivo MultiverCidades da Amazônia       \n'
                    '- Instituto Amazônia Cultural       \n'
                    '- Instituto Amazônia Cultural       \n'
                    '- Grupo de Capoeira Sou Angoleiro       \n'
                    '- Coletivo Lutar Sempre        \n',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      height: 1.5.sp,
                    ),
                  ),
                  SizedBox(height: 18.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Apoiadores: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    '- Laboratório Saber e Conviver/Faesa/UFPA\n'
                    '- Clínica de Direito à Cidade/PPGDDA/UFPA\n'
                    '- Movimento Bandeirantes São Domingos de Gusmão\n'
                    '- Rede de Supermercado Econômico\n',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      height: 1.5.sp,
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            )),
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}

