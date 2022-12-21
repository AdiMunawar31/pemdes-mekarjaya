import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pemdes_mekarjaya/app/style/app_color.dart';

import '../controllers/detail_presence_controller.dart';

class DetailPresenceView extends GetView<DetailPresenceController> {
  final Map<String, dynamic> presenceData = Get.arguments;

  DetailPresenceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Presence Detail',
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
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        children: [
          //! Absen Masuk ==================================================================================
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.secondaryExtraSoft, width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Masuk',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          (presenceData["masuk"] == null) ? "-" : "${presenceData["masuk"]["jam"]}",
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    //presence date
                    Text(
                      DateFormat.yMMMEd('id_ID').format(DateTime.parse(presenceData["tanggal"])),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Text(
                  'status',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  (presenceData["masuk"]?["in_area"] == true) ? "Didalam Area" : "Diluar Area",
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 14),
                const Text(
                  'lokasi',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  (presenceData["masuk"] == null) ? "-" : "Desa ${presenceData["masuk"]["lokasi"]}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 150 / 100,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          //! Keluar =============================================================================================
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.secondaryExtraSoft, width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Keluar',
                          style: TextStyle(color: AppColor.secondary),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          (presenceData["keluar"] == null) ? "-" : "${presenceData["keluar"]["jam"]}",
                          style: TextStyle(color: AppColor.secondary, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    //presence date
                    Text(
                      DateFormat.yMMMEd('id_ID').format(DateTime.parse(presenceData["tanggal"])),
                      style: TextStyle(color: AppColor.secondary),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  'status',
                  style: TextStyle(color: AppColor.secondary),
                ),
                const SizedBox(height: 4),
                Text(
                  (presenceData["keluar"]?["in_area"] == true) ? "Didalam Area" : "Diluar Area",
                  style: TextStyle(color: AppColor.secondary, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 14),
                Text(
                  'lokasi',
                  style: TextStyle(color: AppColor.secondary),
                ),
                const SizedBox(height: 4),
                Text(
                  (presenceData["keluar"] == null) ? "-" : "Desa ${presenceData["keluar"]["lokasi"]}",
                  style: TextStyle(
                    color: AppColor.secondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 150 / 100,
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
