import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy_admin/core/colors.dart';
import 'package:pocketbuy_admin/view/login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    waiting();
    return Scaffold(
      body: Center(
          child: Text(
        'Pocket Buy \n     Admin',
        style: TextStyle(fontSize: 50, color: kPrimaryColor),
      )),
    );
  }

  waiting() async {
    Timer(Duration(seconds: 3), () {
      Get.off(LoginScreen());
    });
  }
}
