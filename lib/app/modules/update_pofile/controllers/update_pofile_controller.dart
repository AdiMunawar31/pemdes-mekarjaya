import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:pemdes_mekarjaya/app/widgets/toast/custom_toast.dart';

class UpdatePofileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController nikC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();
  XFile? image;

  Future<void> updateProfile() async {
    String uid = auth.currentUser!.uid;
    if (nikC.text.isNotEmpty && namaC.text.isNotEmpty && emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        Map<String, dynamic> data = {
          "nama": namaC.text,
        };
        if (image != null) {
          //? unggah gambar avatar ke penyimpanan firebase
          File file = File(image!.path);
          String ext = image!.name.split(".").last;
          String upDir = "$uid/avatar.$ext";
          await storage.ref(upDir).putFile(file);
          String avatarUrl = await storage.ref(upDir).getDownloadURL();

          data.addAll({"avatar": avatarUrl});
        }
        await firestore.collection("pegawai").doc(uid).update(data);
        image = null;
        Get.back();
        CustomToast.successToast('Berhasil', 'Berhasil memperbaharui Profil');
      } catch (e) {
        CustomToast.errorToast('Error', 'Tidak Dapat Memperbarui Profil. Terjadi Kesalahan : ${e.toString()}');
      } finally {
        isLoading.value = false;
      }
    } else {
      CustomToast.errorToast('Error', 'Anda harus mengisi semua formulir');
    }
  }

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // print(image!.path);
      // print(image!.name.split(".").last);
    }
    update();
  }

  void deleteProfile() async {
    String uid = auth.currentUser!.uid;
    try {
      await firestore.collection("pegawai").doc(uid).update({
        "avatar": FieldValue.delete(),
      });
      Get.back();

      Get.snackbar("Berhasil", "Berhasil delete avatar profile");
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "Tidak dapat delete avatar profile. Karena ${e.toString()}");
    } finally {
      update();
    }
  }
}
