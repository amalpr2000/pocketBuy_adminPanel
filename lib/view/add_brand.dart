import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocketbuy_admin/core/colors.dart';
import 'package:pocketbuy_admin/core/constants.dart';
import 'package:pocketbuy_admin/service/add_brand_service.dart';
import 'package:pocketbuy_admin/utils/snackbar.dart';

class AddBrand extends StatefulWidget {
  AddBrand({super.key});

  @override
  State<AddBrand> createState() => _AddBrandState();
}

class _AddBrandState extends State<AddBrand> {
  XFile? image;
  TextEditingController brandNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: const Text('Add Brand'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  log('irmr55ds5afjl;kfsaj');
                  final pickedImg = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  log(pickedImg.toString());
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
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(12),
                child: TextFormField(
                  controller: brandNameController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 0.0),
                      ),
                      labelText: 'Enter the brand name',
                      labelStyle: const TextStyle(color: kSecondaryColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(
                        Icons.branding_watermark_rounded,
                        color: kPrimaryColor,
                      )),
                ),
              ),
              kHeight40,
              SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      // style: ButtonStyle(backgroundColor: Colors.orange),
                      onPressed: () async {
                        await addBrand(image!);
                        snack(context,
                            message:
                                '${brandNameController.text} brand added successfully',
                            color: Colors.green);
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Add Brand',
                        style: TextStyle(color: kwhite),
                      ))),
            ],
          ),
        ));
  }

  addBrand(XFile image) async {
    final firebaseImgUrl = await AddBrandService().imgUpload(image);
    await AddBrandService().addBrand(
        brandImg: firebaseImgUrl, brandName: brandNameController.text);
  }
}
