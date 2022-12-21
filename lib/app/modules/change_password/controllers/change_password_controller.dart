import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pemdes_mekarjaya/app/widgets/toast/custom_toast.dart';

class ChangePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController currentPassC = TextEditingController();
  TextEditingController newPassC = TextEditingController();
  TextEditingController confirmNewPassC = TextEditingController();

  RxBool oldPassObs = true.obs;
  RxBool newPassObs = true.obs;
  RxBool newPassCObs = true.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> updatePassword() async {
    if (currentPassC.text.isNotEmpty && newPassC.text.isNotEmpty && confirmNewPassC.text.isNotEmpty) {
      if (newPassC.text == confirmNewPassC.text) {
        isLoading.value = true;
        try {
          String emailUser = auth.currentUser!.email!;
          //? checking if the current password is true
          await auth.signInWithEmailAndPassword(email: emailUser, password: currentPassC.text);
          //? update password
          await auth.currentUser!.updatePassword(newPassC.text);

          Get.back();
          CustomToast.successToast('Berhasil', 'Berhasil mengganti password baru');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong-password') {
            CustomToast.errorToast('Error', 'kata sandi saat ini salah');
          } else {
            CustomToast.errorToast('Error', 'Tidak dapat memperbarui kata sandi karena : ${e.code}');
          }
        } catch (e) {
          CustomToast.errorToast('Error', 'Terjadi Kesalahan : ${e.toString()}');
        } finally {
          isLoading.value = false;
        }
      } else {
        CustomToast.errorToast('Error', 'Kata sandi baru dan konfirmasi kata sandi tidak cocok');
      }
    } else {
      CustomToast.errorToast('Error', 'Semua formulir harus diisi');
    }
  }
}
