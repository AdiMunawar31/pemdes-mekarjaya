import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/success_controller.dart';

class SuccessView extends GetView<SuccessController> {
  const SuccessView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SuccessView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SuccessView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
