import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:pemdes_mekarjaya/app/style/app_color.dart';
import 'package:pemdes_mekarjaya/app/widgets/custom_input.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/arrow-left.svg',
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 35 / 100,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 32),
            decoration: BoxDecoration(
              gradient: AppColor.primaryGradient,
              image: const DecorationImage(
                image: AssetImage('assets/images/pattern-1-1.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 30),
                Text(
                  "Aplikasi Presensi\nPemdes Mekarjaya",
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontFamily: 'poppins',
                    height: 150 / 100,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                // Text(
                //   "by: Adi Munawar",
                //   style: TextStyle(color: Colors.white),
                // ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 65 / 100,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 36, bottom: 84),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Password Baru',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Anda masuk dengan kata sandi default. Untuk melanjutkan, Anda harus membuat kata sandi baru.",
                        style: TextStyle(
                          color: AppColor.secondarySoft,
                          height: 150 / 100,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => CustomInput(
                    controller: controller.passC,
                    label: 'Password Baru',
                    hint: '*****************',
                    obsecureText: controller.newPassObs.value,
                    suffixIcon: IconButton(
                      icon: (controller.newPassObs.value != false)
                          ? SvgPicture.asset('assets/icons/show.svg')
                          : SvgPicture.asset('assets/icons/hide.svg'),
                      onPressed: () {
                        controller.newPassObs.value = !(controller.newPassObs.value);
                      },
                    ),
                  ),
                ),
                Obx(
                  () => CustomInput(
                    controller: controller.confirmPassC,
                    label: 'Konfirmasi Password Baru',
                    hint: '*****************',
                    obsecureText: controller.newPassCObs.value,
                    suffixIcon: IconButton(
                      icon: (controller.newPassCObs.value != false)
                          ? SvgPicture.asset('assets/icons/show.svg')
                          : SvgPicture.asset('assets/icons/hide.svg'),
                      onPressed: () {
                        controller.newPassCObs.value = !(controller.newPassCObs.value);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Obx(
                  () => SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.isLoading.isFalse) {
                          // print('exc');
                          await controller.newPassword();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        (controller.isLoading.isFalse) ? 'Konfirmasi' : 'Loading...',
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
