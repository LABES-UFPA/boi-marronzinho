import 'package:boi_marronzinho/app/modules/doacoes/doacoes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoacoesView extends GetView<DoacoesController> {
  DoacoesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF660D0D),
        body: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: AppBarClipper(),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Image.asset(
                              'assets/images/icons/mingcute_arrow-up-fill.png',
                              height: 40,
                              width: 40,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          const Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 10),
                                Icon(
                                  Icons.favorite,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                SizedBox(width: 5),
                                Center(
                                  child: Text(
                                    'Doe Agora',
                                    style: TextStyle(
                                      fontSize: 36,
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
            Container(
              child: Image.asset(
                "assets/images/logo/logo_boi_marronzinho.png",
                width: 200.0,
                height: 275.0,
              ),
            ),
            const Text(
              'Ajude o Boi Marronzinho',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  buildPaymentButton('PIX'),
                  SizedBox(height: 16),
                  buildPaymentButton('Cartão'),
                  SizedBox(height: 16),
                  buildPaymentButton('Boleto'),
                  SizedBox(height: 16),
                  buildPaymentButton('Outro'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentButton(String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold, // Deixar o texto em negrito
            color: Colors.black, // Cor do texto (preto)
          ),
        ),
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  CircleButton(
      {required this.icon, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.orangeAccent, width: 2),
              color: Colors.white,
            ),
            child: Icon(icon, color: Colors.orangeAccent),
          ),
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width - 60, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
