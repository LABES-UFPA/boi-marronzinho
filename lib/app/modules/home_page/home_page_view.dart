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
                Container(
                  height: 170,
                  color: Color(0xFFF69302),
                ),
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
                              icon: 'assets/images/logo/ImgBoi.png',
                              text: 'Boi Marronzinho',
                              onPressed: () {
                                // controller.onBoiMarronzinhoPressed();
                              },
                            ),
                            CircleButton(
                              icon: 'assets/images/icons/shopping-bag.png',
                              text: 'Loja',
                              onPressed: () {
                                // controller.onLojaPressed();
                              },
                            ),
                            CircleButton(
                              icon: 'assets/images/icons/user.png',
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
                //padding: EdgeInsets.zero,
                children: [
                  buildMenuItem('Eventos', Icons.event,
                      Color(0xFFF69302), Color(0xFFBA400A), () {
                    controller.onEventosPressed();
                  }),
                  buildMenuItem('Mapa', Icons.location_on, Color(0xFFBA400A),
                      Color(0xFFB12623), () {
                    controller.onMapaPressed();
                  }),
                  buildMenuItem('Sobre nós', Icons.info, Color(0xFFB12623),
                      Color(0XFF660D0D), () {
                    controller.onSobreNosPressed();
                  }),
                  buildMenuItem('Doe Agora', Icons.favorite,
                      Color(0XFF660D0D), Color(0xFF5C0B32), () {
                    controller.onDoeAgoraPressed();
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(String text, IconData icon, Color color,
      Color nextcolor, VoidCallback onPressed) {
    return Container(
      height: 128,
      color: nextcolor,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(60),
        ),
        child: InkWell(
          onTap: onPressed,
          child: Container(
           
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: color,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 40),
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
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final String icon;
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
              
                child: Image.asset(icon,
                fit: BoxFit.scaleDown,),
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
