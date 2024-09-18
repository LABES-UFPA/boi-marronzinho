import 'package:boi_marronzinho/app/modules/home_page/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageView extends GetView<HomePageController> {
  HomePageView({Key? key}) : super(key: key);

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
            // Itens da lista
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  buildMenuItem('Eventos', Icons.calendar_today, Color(0xFFF69302)),
                  buildMenuItem('Mapa', Icons.map, Color(0xFFBA400A)),
                  buildMenuItem('Sobre nós', Icons.info, Color(0xFFB12623)),
                  buildMenuItem('Doe Agora', Icons.favorite, Color(0XFF660D0D)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(String text, IconData icon, Color color) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(60),
      ),
      child: Container(
        padding: EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: color,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 40),
              SizedBox(width: 20),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
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

