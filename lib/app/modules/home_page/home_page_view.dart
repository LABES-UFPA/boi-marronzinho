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
            Expanded(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: 500,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(60),
                          decoration: BoxDecoration(
                            color: Color(0XFF660D0D), //0XFF660D0D
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(80)),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 80),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.favorite,
                                      color: Colors.white, size: 40),
                                  SizedBox(width: 20),
                                  Text(
                                    'Doe Agora',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 380,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(60),
                          decoration: BoxDecoration(
                            color: Color(0xFFB12623),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(80)),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 50),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.info,
                                      color: Colors.white, size: 40),
                                  SizedBox(width: 20),
                                  Text(
                                    'Sobre nós',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 246,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(55),
                          decoration: BoxDecoration(
                            color: Color(0xFFBA400A),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(80)),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 50),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.map,
                                      color: Colors.white, size: 40),
                                  SizedBox(width: 20),
                                  Text(
                                    'Mapa',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 105,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(63),
                          decoration: BoxDecoration(
                            color: Color(0xFFF69302),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(80)),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.calendar_today,
                                      color: Colors.white, size: 40),
                                  SizedBox(width: 20),
                                  Text(
                                    'Eventos',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          padding: EdgeInsets.all(45),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(80)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
