import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pemdes_mekarjaya/app/controllers/page_index_controller.dart';
import 'package:pemdes_mekarjaya/app/controllers/presence_controller.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(PresenceController(), permanent: true);
  Get.put(PageIndexController(), permanent: true);

  await initializeDateFormatting('id_ID', null).then((_) {
    runApp(
      StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
          // print(snapshot.data);
          return GetMaterialApp(
            title: "Application",
            debugShowCheckedModeBanner: false,
            initialRoute: snapshot.data != null ? Routes.HOME : Routes.LOGIN,
            // initialRoute: Routes.SPLASH,
            getPages: AppPages.routes,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              fontFamily: 'inter',
            ),
          );
        },
      ),
    );
  });
}
