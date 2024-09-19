import 'package:boi_marronzinho/app/modules/doacoes/doacoes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoacoesView extends GetView<DoacoesController> {
  DoacoesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF5C0B32),
        body: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: AppBarClipper(),
                  child: Container(
                    height: 170,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleButton(
                              icon: Icons.event, 
                              text: 'Boi Marronzinho',
                              onPressed: () {
                                // controller.onBoiMarronzinhoPressed();
                              },
                            ),
                            CircleButton(
                              icon: Icons.store, 
                              text: 'Loja',
                              onPressed: () {
                                // controller.onLojaPressed();
                              },
                            ),
                            CircleButton(
                              icon: Icons.person, 
                              text: 'Perfil',
                              onPressed: () {
                                // controller.onPerfilPressed();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 16,
                  child: Icon(
                    Icons.notifications,
                    color: Color(0xFFFFCC4D),
                    size: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  CircleButton({required this.icon, required this.text, required this.onPressed});

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
    
    path.lineTo(0, size.height - 60);
    
    path.quadraticBezierTo(0, size.height, 60, size.height);
    
    path.lineTo(size.width, size.height);
    
    path.lineTo(size.width, 0);
    
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
