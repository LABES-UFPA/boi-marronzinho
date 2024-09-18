import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:flutter/material.dart';

class FlowInitialController extends BaseController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  // void onLogin() {
  //   Get.toNamed(LoginModule.path);
  // }

  // void onRegister() {
  //   Get.toNamed(UserRegisterModule.path);
  // }
}
