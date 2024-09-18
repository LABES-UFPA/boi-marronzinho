import 'package:boi_marronzinho/app/modules/home_page/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageView extends GetView<HomePageController> {
  HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // AppBar com design personalizado
            Stack(
              children: [
                ClipPath(
                  clipper: AppBarClipper(),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 40), // Espaço para a StatusBar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleButton(
                              icon: Icons.event, 
                              text: 'Boi Marronzinho',
                              onPressed: () {
                                // Implementação da ação no controller
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
                  right: 16,
                  top: 40,
                  child: Icon(Icons.notifications, color: Colors.yellow),
                ),
              ],
            ),
            // Itens da lista
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  buildMenuItem('Eventos', Icons.calendar_today, Colors.orange),
                  buildMenuItem('Mapa', Icons.map, Colors.redAccent),
                  buildMenuItem('Sobre nós', Icons.info, Colors.deepOrange),
                  buildMenuItem('Doe Agora', Icons.favorite, Colors.purple),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(String text, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(20),
      color: color,
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 40),
          SizedBox(width: 20),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget para os botões circulares na AppBar
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

// Clipper personalizado para criar o efeito da AppBar arredondada
class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(0, size.height, 50, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
