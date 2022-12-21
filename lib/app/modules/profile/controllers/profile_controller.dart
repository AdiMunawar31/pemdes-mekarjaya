import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pemdes_mekarjaya/app/routes/app_pages.dart';
import 'package:pemdes_mekarjaya/app/widgets/dialog/custom_alert_dialog.dart';

class ProfileController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String? uid = auth.currentUser?.uid;
    yield* firestore.collection("pegawai").doc(uid).snapshots();
  }

  void logout() async {
    CustomAlertDialog.logout(
        title: "Logout",
        message: "Apakah anda yakin ingin logout?",
        onConfirm: () async {
          await auth.signOut();
          Get.offAllNamed(Routes.LOGIN);
        },
        onCancel: () => Get.back());
  }
}
