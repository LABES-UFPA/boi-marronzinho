import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoiButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color color;
  final Function callbackOnPressed;

  BoiButton(
      {super.key,
      required this.text,
      required this.color,
      required this.width,
      required this.height,
      required this.callbackOnPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: () => callbackOnPressed(),
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ))),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp),
          )),
    );
  }
}
