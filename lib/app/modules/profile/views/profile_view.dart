import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pemdes_mekarjaya/app/controllers/page_index_controller.dart';
import 'package:pemdes_mekarjaya/app/routes/app_pages.dart';
import 'package:pemdes_mekarjaya/app/style/app_color.dart';
import 'package:pemdes_mekarjaya/app/widgets/custom_bottom_navigation_bar.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final pageIndexController = Get.find<PageIndexController>();

  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              Map<String, dynamic>? user = snapshot.data?.data();
              return ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 36),
                children: [
                  const SizedBox(height: 16),
                  // section 1 - profile
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        margin: const EdgeInsets.only(top: 16.0),
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(
                            width: 4,
                            color: Colors.blue,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.network(
                            (user?['avatar'] != null && user?['avatar'] != '')
                                ? user!['avatar']
                                : 'https://ui-avatars.com/api/?name=${user?["nama"]}/',
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16, bottom: 4),
                        child: Text(
                          user?["nama"] != null ? user!['nama'] : 'Loading...',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        user?["pekerjaan"] != null ? user!['pekerjaan'] : 'Loading...',
                        style: TextStyle(color: AppColor.secondarySoft),
                      ),
                    ],
                  ),
                  // section 2 - menu
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 42),
                    child: Column(
                      children: [
                        MenuTile(
                          title: 'Perbaharui Profil',
                          icon: SvgPicture.asset(
                            'assets/icons/profile-1.svg',
                          ),
                          onTap: () => Get.toNamed(Routes.UPDATE_POFILE, arguments: user),
                        ),
                        (user?["role"] == "admin")
                            ? MenuTile(
                                title: 'Tambah Pegawai',
                                icon: SvgPicture.asset(
                                  'assets/icons/people.svg',
                                ),
                                onTap: () => Get.toNamed(Routes.ADD_EMPLOYEE),
                              )
                            : const SizedBox(),
                        MenuTile(
                          title: 'Ganti Password',
                          icon: SvgPicture.asset(
                            'assets/icons/password.svg',
                          ),
                          onTap: () => Get.toNamed(Routes.CHANGE_PASSWORD),
                        ),
                        MenuTile(
                          isDanger: true,
                          title: 'Logout',
                          icon: SvgPicture.asset(
                            'assets/icons/logout.svg',
                          ),
                          onTap: controller.logout,
                        ),
                        Container(
                          height: 1,
                          color: AppColor.primaryExtraSoft,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final void Function() onTap;
  final bool isDanger;

  const MenuTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isDanger = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColor.secondaryExtraSoft,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              margin: const EdgeInsets.only(right: 24),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.primaryExtraSoft,
                borderRadius: BorderRadius.circular(100),
              ),
              child: icon,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: (isDanger == false) ? AppColor.secondary : AppColor.error,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: SvgPicture.asset(
                'assets/icons/arrow-right.svg',
                color: (isDanger == false) ? AppColor.secondary : AppColor.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
