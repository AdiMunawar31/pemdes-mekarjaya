import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pemdes_mekarjaya/app/routes/app_pages.dart';
import 'package:pemdes_mekarjaya/app/widgets/dialog/custom_alert_dialog.dart';
import 'package:pemdes_mekarjaya/app/widgets/toast/custom_toast.dart';
import 'package:pemdes_mekarjaya/company_data.dart';

class AddEmployeeController extends GetxController {
  @override
  onClose() {
    nikC.dispose();
    namaC.dispose();
    emailC.dispose();
    adminPassC.dispose();
  }

  RxBool isLoading = false.obs;
  RxBool isLoadingCreatePegawai = false.obs;

  TextEditingController nikC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController pekerjaanC = TextEditingController();
  TextEditingController adminPassC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String getDefaultPassword() {
    return CompanyData.defaultPassword;
  }

  String getDefaultRole() {
    return CompanyData.defaultRole;
  }

  Future<void> addEmployee() async {
    if (nikC.text.isNotEmpty && namaC.text.isNotEmpty && emailC.text.isNotEmpty && pekerjaanC.text.isNotEmpty) {
      isLoading.value = true;
      CustomAlertDialog.confirmAdmin(
        title: 'Konfirmasi Admin',
        message: 'Anda perlu mengonfirmasi bahwa Anda adalah administrator dengan memasukkan kata sandi Anda',
        onCancel: () {
          isLoading.value = false;
          Get.back();
        },
        onConfirm: () async {
          if (isLoadingCreatePegawai.isFalse) {
            await createEmployeeData();
            isLoading.value = false;
          }
        },
        controller: adminPassC,
      );
    } else {
      isLoading.value = false;
      CustomToast.errorToast('Error', 'Anda harus mengisi semua formulir');
    }
  }

  createEmployeeData() async {
    if (adminPassC.text.isNotEmpty) {
      isLoadingCreatePegawai.value = true;
      String adminEmail = auth.currentUser!.email!;
      try {
        //? checking if the pass is match
        await auth.signInWithEmailAndPassword(email: adminEmail, password: adminPassC.text);
        //? get default password
        String defaultPassword = getDefaultPassword();
        String defaultRole = getDefaultRole();
        //?  if the password is match, then continue the create user process
        UserCredential employeeCredential = await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: defaultPassword,
        );

        if (employeeCredential.user != null) {
          String uid = employeeCredential.user!.uid;
          DocumentReference employee = firestore.collection("pegawai").doc(uid);
          await employee.set({
            "nik": nikC.text,
            "nama": namaC.text,
            "email": emailC.text,
            "role": defaultRole,
            "jabatan": pekerjaanC.text,
            "uid": uid,
            "created_at": DateTime.now().toIso8601String(),
          });

          await employeeCredential.user!.sendEmailVerification();

          //? need to logout because the current user is changed after adding new user
          await auth.signOut();
          //?  need to relogin to admin account
          await auth.signInWithEmailAndPassword(email: adminEmail, password: adminPassC.text);

          //?  clear form
          Get.back();
          Get.offAllNamed(Routes.SUCCESS_ADD_EMPLOYEE);
          CustomToast.successToast('Berhasil', 'Berhasil menambahkan pegawai');

          isLoadingCreatePegawai.value = false;
        }
      } on FirebaseAuthException catch (e) {
        isLoadingCreatePegawai.value = false;
        if (e.code == 'weak-password') {
          CustomToast.errorToast('Error', 'kata sandi default terlalu pendek');
        } else if (e.code == 'email-already-in-use') {
          CustomToast.errorToast('Error', 'Email pegawai sudah terdaftar');
        } else if (e.code == 'wrong-password') {
          CustomToast.errorToast('Error', 'Password Salah');
        } else {
          CustomToast.errorToast('Error', 'error : ${e.code}');
        }
      } catch (e) {
        isLoadingCreatePegawai.value = false;
        CustomToast.errorToast('Error', 'error : ${e.toString()}');
      }
    } else {
      CustomToast.errorToast('Error', 'Anda perlu memasukkan kata sandi');
    }
  }
}
