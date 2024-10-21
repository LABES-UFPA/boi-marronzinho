import 'dart:developer';

import 'package:boi_marronzinho/app/data/enumerators/storage_keys.enum.dart';
import 'package:boi_marronzinho/app/data/providers/bm_api_client/bm_api_client.provider.dart';
import 'package:boi_marronzinho/app/data/repositories/user_credentials/user_credentials_repository.dart';
import 'package:boi_marronzinho/app/data/storage/memory_storage.dart';
import 'package:boi_marronzinho/app/data/util/helpers/index.dart';
import 'package:boi_marronzinho/app/main_getx_app.dart';
import 'package:boi_marronzinho/app/modules/home_page/home_page_module.dart';
import 'package:boi_marronzinho/app/modules/initial/flow_initial/flow_initial_module.dart';
import 'package:boi_marronzinho/app/modules/login/login_module.dart';
import 'package:boi_marronzinho/app/modules/splash/splash_module.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initProviders();

  // TODO: Iniciar timer de expiração do Token

  // Checa se o Token expirou
  if (MemoryStore(StorageKeys.USER_TOKEN).read<String>() != null) {
    DateTime tokenExpirationDate = DateTime.fromMillisecondsSinceEpoch(
        JWT.decode(MemoryStore(StorageKeys.USER_TOKEN).read()).payload["exp"] * 1000
    );
    if (DateTime.now().isAfter(tokenExpirationDate)) {
      log("Token expirado. Removendo do Cache");
      MemoryStore(StorageKeys.USER_TOKEN).remove();
    }
  }

  final initialPage = getInitPage();
  FlutterNativeSplash.remove();

  runApp(
    ScreenUtilInit(
      designSize: const Size(393, 852),
      ensureScreenSize: true,
      splitScreenMode: false,
      builder: (_, __) => MainGetXApp(initialPage),
    ),
  );

}

// TODO: Descobrir onde tá salvando e deletar no logout
String getInitPage() {
  final authToken = MemoryStore(StorageKeys.USER_TOKEN).read<String>() ?? '';
  final credentials = UserCredentialsRepository().getCredentials();

  return authToken.isEmpty || credentials.email.isEmpty
      ? SplashModule.path
      : HomeModule.path;
}

Future<void> initProviders() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GetStorage.init();

  await Helpers().setLocalMode(false);
  await Get.put<BmApiClient>(BmApiClient());

  await ScreenUtil.ensureScreenSize();
}
