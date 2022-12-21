import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pemdes_mekarjaya/app/routes/app_pages.dart';
import 'package:pemdes_mekarjaya/app/style/app_color.dart';

class PresenceTile extends StatelessWidget {
  final Map<String, dynamic> presenceData;
  const PresenceTile({Key? key, required this.presenceData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.DETAIL_PRESENCE, arguments: presenceData),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: AppColor.primaryExtraSoft,
          ),
        ),
        padding: const EdgeInsets.only(left: 24, top: 20, right: 29, bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Jam Masuk",
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      (presenceData["masuk"] == null)
                          ? "-"
                          : DateFormat.Hms().format(DateTime.parse(presenceData["masuk"]["tanggal"])),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Jam Pulang",
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      (presenceData["pulang"] == null)
                          ? "-"
                          : DateFormat.Hms().format(DateTime.parse(presenceData["pulang"]["tanggal"])),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              DateFormat.yMMMEd('id_ID').format(DateTime.parse(presenceData["tanggal"])),
              style: TextStyle(
                fontSize: 10,
                color: AppColor.secondarySoft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
