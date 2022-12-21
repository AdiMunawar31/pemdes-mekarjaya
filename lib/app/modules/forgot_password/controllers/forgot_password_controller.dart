import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pemdes_mekarjaya/app/widgets/toast/custom_toast.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> sendEmail() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      // print("called");
      try {
        // print("success");
        auth.sendPasswordResetEmail(email: emailC.text);
        Get.back();
        CustomToast.successToast("Berhasil", "Kami telah mengirimkan tautan reset kata sandi ke email Anda");
      } catch (e) {
        CustomToast.errorToast("Error",
            "Tidak dapat mengirim tautan reset kata sandi ke email Anda. Terjadi Kesalahan karena : ${e.toString()}");
      } finally {
        isLoading.value = false;
      }
    } else {
      CustomToast.errorToast("Error", "Email harus diisi");
    }
  }
}
