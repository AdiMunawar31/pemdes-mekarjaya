import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pemdes_mekarjaya/app/style/app_color.dart';

import '../../../routes/app_pages.dart';
import '../controllers/success_add_employee_controller.dart';

class SuccessAddEmployeeView extends GetView<SuccessAddEmployeeController> {
  const SuccessAddEmployeeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Berhasil',
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
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 100),
          Image.asset(
            'assets/images/logo.png',
            height: 140,
          ),
          //
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Berhasil menambahkan pegawai',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'poppins',
              ),
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () => Get.toNamed(Routes.PROFILE),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                padding: const EdgeInsets.symmetric(vertical: 18),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Kembali ke Profile',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'poppins',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
