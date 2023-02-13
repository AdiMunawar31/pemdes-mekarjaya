import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pemdes_mekarjaya/app/routes/app_pages.dart';
import 'package:pemdes_mekarjaya/app/widgets/toast/custom_toast.dart';

class ScanQrController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final Map<String, dynamic> data = Get.arguments;

  String scannedQr = '';

  Future<void> scanQR() async {
    try {
      scannedQr = await FlutterBarcodeScanner.scanBarcode('#37B6F8', 'Cancel', true, ScanMode.QR);
      if (auth.currentUser?.email == scannedQr) {
        await processPresence();
      } else {
        CustomToast.errorToast("Error", "QR Code ini tidak sesuai: $scannedQr");
      }
    } on PlatformException {
      CustomToast.errorToast("Error", "Internal Server Error");
    }
  }

  firstPresence(
    CollectionReference<Map<String, dynamic>> presenceCollection,
    String todayDocId,
  ) async {
    await presenceCollection.doc(todayDocId).set(
      {
        "tanggal": DateTime.now().toIso8601String(),
        "masuk": {
          "tanggal": data['tanggal'],
          "jam": data['jam'],
          "hari": data['hari'],
          "latitude": data['latitude'],
          "longitude": data['longitude'],
          "lokasi": data['lokasi'],
          "in_area": data['in_area'],
          "jarak": data['jarak'],
          "keterangan": data['keterangan']
        }
      },
    );
    Get.toNamed(Routes.SUCCESS);
    CustomToast.successToast("Berhasil", "Berhasil absen masuk");
  }

  checkinPresence(
    CollectionReference<Map<String, dynamic>> presenceCollection,
    String todayDocId,
  ) async {
    await presenceCollection.doc(todayDocId).set(
      {
        "tanggal": DateTime.now().toIso8601String(),
        "masuk": {
          "tanggal": data['tanggal'],
          "jam": data['jam'],
          "hari": data['hari'],
          "latitude": data['latitude'],
          "longitude": data['longitude'],
          "lokasi": data['lokasi'],
          "in_area": data['in_area'],
          "jarak": data['jarak'],
          "keterangan": data['keterangan']
        }
      },
    );
    Get.toNamed(Routes.SUCCESS);
    CustomToast.successToast("Berhasil", "Berhasil absen masuk");
  }

  checkoutPresence(
    CollectionReference<Map<String, dynamic>> presenceCollection,
    String todayDocId,
  ) async {
    await presenceCollection.doc(todayDocId).update(
      {
        "pulang": {
          "tanggal": data['tanggal'],
          "jam": data['jam'],
          "hari": data['hari'],
          "latitude": data['latitude'],
          "longitude": data['longitude'],
          "lokasi": data['lokasi'],
          "in_area": data['in_area'],
          "jarak": data['jarak'],
        }
      },
    );
    Get.toNamed(Routes.SUCCESS);
    CustomToast.successToast("Berhasil", "Berhasil absen pulang");
  }

  Future<void> processPresence() async {
    String uid = auth.currentUser!.uid;
    DateTime now = DateTime.now();
    String todayDocId = DateFormat.yMd().format(now).replaceAll('/', '-');

    String jamStr = DateFormat.Hms().format(now).split(':').first;
    var jamSekarang = int.parse(jamStr);

    CollectionReference<Map<String, dynamic>> presenceCollection =
        firestore.collection("pegawai").doc(uid).collection("presensi");
    QuerySnapshot<Map<String, dynamic>> snapshotPreference = await presenceCollection.get();

    if (snapshotPreference.docs.isEmpty) {
      //? :  tidak pernah ada -> setel cek di kehadiran
      firstPresence(presenceCollection, todayDocId);
    } else {
      DocumentSnapshot<Map<String, dynamic>> todayDoc = await presenceCollection.doc(todayDocId).get();

      //? : sudah ada sebelumnya ( lain hari ) -> sudah check in hari ini atau check out?
      if (todayDoc.exists == true) {
        Map<String, dynamic>? dataPresenceToday = todayDoc.data();

        // ? : sudah absen masuk
        if (dataPresenceToday?["pulang"] != null) {
          // ? : sudah absen masuk dan pulang
          CustomToast.successToast("Berhasil", "Anda sudah absen masuk dan pulang");
        } else {
          // ? : sudah absen masuk tapi belum absen pulang
          if (jamSekarang > 12) {
            checkoutPresence(presenceCollection, todayDocId);
          } else {
            CustomToast.errorToast("Error", "Anda hanya bisa absen pulang mulai dari jam 13:00");
          }
        }
      } else {
        // ? : belum absen masuk hari ini
        checkinPresence(presenceCollection, todayDocId);
      }
    }
  }
}
