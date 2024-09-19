import 'package:boi_marronzinho/app/data/providers/bm_api_client/bm_api_client.provider.dart';
import 'package:boi_marronzinho/app/data/util/helpers/index.dart';
import 'package:boi_marronzinho/app/main_getx_app.dart';
import 'package:boi_marronzinho/app/modules/home_page/home_page_module.dart';
import 'package:boi_marronzinho/app/modules/initial/flow_initial/flow_initial_module.dart';
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

  final initialPage = getInitPage();
  FlutterNativeSplash.remove();

  runApp(
    ScreenUtilInit(
      designSize: const Size(430, 932),
      ensureScreenSize: true,
      splitScreenMode: false,
      builder: (_, __) => MainGetXApp(initialPage),
    ),
  );

}

String getInitPage() {
  return  HomeModule.path;
}

Future<void> initProviders() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GetStorage.init();

  await Helpers().setLocalMode(false);
  await Get.put<BmApiClient>(BmApiClient());

  await ScreenUtil.ensureScreenSize();
}