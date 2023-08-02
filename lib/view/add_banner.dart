import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocketbuy_admin/core/colors.dart';
import 'package:pocketbuy_admin/core/constants.dart';
import 'package:pocketbuy_admin/service/banner_service.dart';
import 'package:pocketbuy_admin/utils/loading_animation.dart';
import 'package:pocketbuy_admin/view/all_banner.dart';

import '../utils/snackbar.dart';

class AddBanner extends StatefulWidget {
  const AddBanner({super.key});

  @override
  State<AddBanner> createState() => _AddBannerState();
}

class _AddBannerState extends State<AddBanner> {
  XFile? image;

  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text('Add Banner'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                final pickedImg =
                    await ImagePicker().pickImage(source: ImageSource.gallery);

                if (pickedImg != null) {
                  image = pickedImg;
                  setState(() {});
                }
              },
              child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: kSecondaryColor,
                      border: Border.all(color: kSecondaryColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: image == null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Add Image',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )
                      : Image.file(File(image!.path))),
            ),
            kHeight40,
            SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    // style: ButtonStyle(backgroundColor: Colors.orange),
                    onPressed: () async {
                      loadingAnimation();
                      await addBanner(image!);
                      Get.back();
                      Get.back();
                      snack(context,
                          message: 'Banner added successfully',
                          color: Colors.green);
                    },
                    child: const Text(
                      'Add Banner',
                      style: TextStyle(color: kwhite),
                    ))),
            kHeight40,
            SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    // style: ButtonStyle(backgroundColor: Colors.orange),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AllBanners()));
                    },
                    child: const Text(
                      'View all banners',
                      style: TextStyle(color: kwhite),
                    ))),
          ],
        ),
      ),
    );
  }

  addBanner(XFile image) async {
    final firebaseImgUrl = await BannerService().imgUpload(image);
    await BannerService().addBanner(bannerImg: firebaseImgUrl);
  }
}
