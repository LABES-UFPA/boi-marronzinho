import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonBox extends StatelessWidget {
  final String text;
  final Future<void> Function() function;
  final Color colortext;

  const ButtonBox({super.key, required this.text, required this.function, required this.colortext});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (){
       function();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF69302),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
                topLeft: Radius.circular(20.r),
              ),
            ),
            padding: EdgeInsets.all(12.h)),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold, // Deixar o texto em negrito
            color: colortext, // Cor do texto (preto)
          ),
        ),
      ),
    );
  }
}
