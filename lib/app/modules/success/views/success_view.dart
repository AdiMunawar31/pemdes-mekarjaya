import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pemdes_mekarjaya/app/routes/app_pages.dart';
import 'package:pemdes_mekarjaya/app/style/app_color.dart';

import '../controllers/success_controller.dart';

class SuccessView extends GetView<SuccessController> {
  const SuccessView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BERHASIL',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 14,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/icons/success.json'),
            const Text(
              'Selamat anda telah berhasil melakukan absensi',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'poppins',
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () async {
                  Get.offAllNamed(Routes.HOME);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'KEMBALI KE HOME',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'poppins',
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
