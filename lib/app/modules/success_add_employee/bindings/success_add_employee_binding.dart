import 'package:get/get.dart';

import '../controllers/success_add_employee_controller.dart';

class SuccessAddEmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuccessAddEmployeeController>(
      () => SuccessAddEmployeeController(),
    );
  }
}
