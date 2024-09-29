import 'package:boi_marronzinho/app/modules/eventos/eventos_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EventosView extends GetView<EventosController> {
  const EventosView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFFB12623),
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: AppBarClipper(),
                child: Container(
                  height: 100,
                  decoration: const BoxDecoration(
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
                          onPressed: () => Get.back(),
                        ),
                        const Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 10),
                              Icon(
                                Icons.event,
                                color: Colors.black,
                                size: 30,
                              ),
                              SizedBox(width: 5),
                              Center(
                                child: Text(
                                  'Eventos',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          /* Foto dos Eventos */
          const SizedBox(
            width: 500,
            height: 500,
            child: ImageCarousel(),
          ),
        ],
      ),
    ));
  }
}

/* Clipper */
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

/* Carrossel das imagens dos eventos */
class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  late PageController _pageController;

  static const String pathImagens = 'assets/images/eventos/';
  List<Image> imagens = [
    Image.asset('${pathImagens}evento-1.jpg'),
    Image.asset('${pathImagens}evento-2.jpg'),
    Image.asset('${pathImagens}evento-3.jpg'),
  ];
  int indexImagens = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      onPageChanged: (page) {
        setState(() {
          indexImagens = page;
        });
      },
      children: imagens,
    );
  }
}
