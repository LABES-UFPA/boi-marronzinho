import 'dart:async';
import 'dart:developer';

import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/enumerators/storage_keys.enum.dart';
import 'package:boi_marronzinho/app/data/storage/memory_storage.dart';
import 'package:boi_marronzinho/app/modules/cadastro/cadastro_module.dart';
import 'package:boi_marronzinho/app/modules/login/login_module.dart';
import 'package:boi_marronzinho/app/modules/splash/splash_module.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:get/get.dart';

class LogoutTimerController extends BaseController {
  RxBool isLoggedIn = false.obs;
  late final Timer _timer;

  // Inicia o timer para logout. Chama a função de 30 em 30 segundos.
  // Só não chama se tiver no login ou splash
  void initLogoutTimer() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      log('LogoutTimer: Verificação periódica em andamento');
      if (Get.currentRoute == LoginModule.path || Get.currentRoute == SplashModule.path || Get.currentRoute == CadastroModule.path) {
        log('LogoutTimer: verificado, mas está numa área que não precisa de Logout');
        return;
      }
      // 'short-circuited or' aqui! Pra não chamar isTokenExpired com Token nulo!
      if (MemoryStore(StorageKeys.USER_TOKEN).read() == null || isTokenExpired()) {
        log('LogoutTimer: Token de usuário expirado! Dando logout!');
        logoutByLogoutTimer();
      }
    });
    isLoggedIn.value = true;
  }

  // Checa se o Token expirou
  bool isTokenExpired() {
    if (MemoryStore(StorageKeys.USER_TOKEN).read<String>() != null) {
      DateTime tokenExpirationDate = DateTime.fromMillisecondsSinceEpoch(
          JWT.decode(MemoryStore(StorageKeys.USER_TOKEN).read()).payload["exp"] * 1000
      );
      if (DateTime.now().isAfter(tokenExpirationDate)) {
        log("Token expirado duranto uso! Logout acionado pelo TimerController!");
        return true;
      }
      return false;
    }
    throw Exception("O token é nulo. Esse código não deveria estar rodando!");
  }

  // Usuário é deslogado pelo timer
  void logoutByLogoutTimer() {
    _timer.cancel();
    cleanCacheEndStore();
    Get.toNamed(SplashModule.path);
    isLoggedIn.value = false;
  }
}
