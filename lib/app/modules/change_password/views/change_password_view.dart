import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:pemdes_mekarjaya/app/style/app_color.dart';
import 'package:pemdes_mekarjaya/app/widgets/custom_input.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ganti Password',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 14,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
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
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),
          Image.asset(
            'assets/images/logo.png',
            height: 140,
          ),
          //
          const SizedBox(height: 40),
          Obx(
            () => CustomInput(
              controller: controller.currentPassC,
              label: 'Password Lama',
              hint: '*************',
              obsecureText: controller.oldPassObs.value,
              suffixIcon: IconButton(
                icon: (controller.oldPassObs.value != false)
                    ? SvgPicture.asset('assets/icons/show.svg')
                    : SvgPicture.asset('assets/icons/hide.svg'),
                onPressed: () {
                  controller.oldPassObs.value = !(controller.oldPassObs.value);
                },
              ),
            ),
          ),
          Obx(
            () => CustomInput(
              controller: controller.newPassC,
              label: 'Password Baru',
              hint: '******************',
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
              controller: controller.confirmNewPassC,
              label: 'Konfirmasi Password Baru',
              hint: '******************',
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
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Obx(
              () => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.updatePassword();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  (controller.isLoading.isFalse) ? "Ganti Password" : 'Loading...',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'poppins',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
