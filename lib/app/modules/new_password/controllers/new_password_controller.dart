import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pemdes_mekarjaya/app/controllers/page_index_controller.dart';
import 'package:pemdes_mekarjaya/app/routes/app_pages.dart';
import 'package:pemdes_mekarjaya/app/widgets/toast/custom_toast.dart';
import 'package:pemdes_mekarjaya/company_data.dart';

class NewPasswordController extends GetxController {
  final pageIndexController = Get.find<PageIndexController>();
  RxBool isLoading = false.obs;
  TextEditingController passC = TextEditingController();
  TextEditingController confirmPassC = TextEditingController();

  RxBool newPassObs = true.obs;
  RxBool newPassCObs = true.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> newPassword() async {
    if (passC.text.isNotEmpty && confirmPassC.text.isNotEmpty) {
      isLoading.value = true;
      if (passC.text == confirmPassC.text) {
        if (passC.text != CompanyData.defaultPassword) {
          await _updatePassword();
          isLoading.value = false;
        } else {
          CustomToast.errorToast('Error', 'Anda harus mengubah kata sandi Anda');
          isLoading.value = false;
        }
      } else {
        CustomToast.errorToast('Error', 'kata sandi tidak cocok');
        isLoading.value = false;
      }
    } else {
      CustomToast.errorToast('Error', 'kamu harus mengisi semua formulir');
    }
  }

  Future<void> _updatePassword() async {
    try {
      String email = auth.currentUser!.email!;
      await auth.currentUser!.updatePassword(passC.text);
      // relogin
      await auth.signOut();
      await auth.signInWithEmailAndPassword(email: email, password: passC.text);
      Get.offAllNamed(Routes.HOME);

      pageIndexController.changePage(0);
      CustomToast.successToast('Berhasil', 'Kata Sandi Pembaruan Sukses');
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'weak-password') {
        CustomToast.errorToast('Error', 'kata sandi terlalu lemah, Anda memerlukan setidaknya 6 karakter');
      }
    } catch (e) {
      isLoading.value = false;
      CustomToast.errorToast('Error', 'Terjadi Kesalahan : ${e.toString()}');
    }
  }
}
