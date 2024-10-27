// Mostra valor com Boicoin do lado
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MostraSaldoBoicoins extends StatelessWidget {
  final int saldo;

  const MostraSaldoBoicoins(this.saldo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.scale(
            scale: 1, child: Image.asset('assets/images/icons/boicoin.png')),
        10.horizontalSpace,
        Text(saldo.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold))
      ],
    );
  }
}
