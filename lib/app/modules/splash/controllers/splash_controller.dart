import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pemdes_mekarjaya/app/routes/app_pages.dart';

class SplashController extends GetxController {
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    startSpalshScreen();
  }

  startSpalshScreen() async {
    var durasi = const Duration(seconds: 5);
    return Timer(durasi, () {
      auth.authStateChanges().listen((user) {
        if (user?.uid != null) {
          // User is signed in
          Get.toNamed(Routes.HOME);
        } else {
          Get.toNamed(Routes.LOGIN);
          // User is signed out
        }
      });
    });
  }
}
