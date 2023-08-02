import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pocketbuy_admin/controller/image_controller.dart';
import 'package:pocketbuy_admin/core/colors.dart';
import 'package:pocketbuy_admin/core/constants.dart';
import 'package:pocketbuy_admin/model/brand_model.dart';
import 'package:pocketbuy_admin/model/product_model.dart';
import 'package:pocketbuy_admin/service/add_brand_service.dart';
import 'package:pocketbuy_admin/service/product_service.dart';
import 'package:pocketbuy_admin/utils/loading_animation.dart';
import 'package:pocketbuy_admin/utils/snackbar.dart';

class AddProduct extends StatefulWidget {
  AddProduct({super.key, required this.brandOptions});
  final List<BrandModel> brandOptions;

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  XFile? image;

  TextEditingController productNameController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  late String? selectedBrand = widget.brandOptions[0].brandName;
  XFile? image1;
  XFile? image2;
  XFile? image3;

  @override
  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    final imageController = Get.put(ImageAddNotifier());
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: const Text('Add Product'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GetBuilder<ImageAddNotifier>(builder: (controller) {
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 190,
                        color: imageController.selectedIndex == null
                            ? const Color(0xFF2C2B2B)
                            : kwhite,
                        child: imageController.selectedIndex == null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Add Image",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: kwhite),
                                  ),
                                  Icon(
                                    Icons.add_a_photo_outlined,
                                    color: kwhite,
                                    size: 28,
                                  )
                                ],
                              )
                            : Center(
                                child: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Image.file(
                                    File(imageController.imageList[
                                        imageController.selectedIndex!]),
                                    // fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),
                      kHeight10,
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) => InkWell(
                                      onTap: () async {
                                        if (index ==
                                            (imageController
                                                .imageList.length)) {
                                          final pickedFile = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.gallery);
                                          if (pickedFile != null) {
                                            if (index == 0) {
                                              image1 = pickedFile;
                                            } else if (index == 1) {
                                              image2 = pickedFile;
                                            } else if (index == 2) {
                                              image3 = pickedFile;
                                            }
                                            imageController.imageAdd(
                                                imagePath: pickedFile.path,
                                                index: index);
                                          }
                                        } else {
                                          imageController.changeIndex(
                                              index: index);
                                        }
                                      },
                                      child: Center(
                                        child: index ==
                                                imageController.imageList.length
                                            ? Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: Colors.grey),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.add_a_photo_outlined,
                                                    color: kwhite,
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                height: 50,
                                                width: 50,
                                                // radius: 35,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    image: DecorationImage(
                                                      image: FileImage(
                                                        File(imageController
                                                            .imageList[index]),
                                                      ),
                                                    )),
                                              ),
                                      ),
                                    ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      width: 20,
                                    ),
                                itemCount: imageController.imageList.length < 3
                                    ? imageController.imageList.length + 1
                                    : 3)
                          ],
                        ),
                      ),
                    ],
                  );
                }),
                kHeight20,
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(12),
                  child: TextFormField(
                    controller: productNameController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        labelText: 'Enter the product name',
                        labelStyle: const TextStyle(color: kSecondaryColor),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(
                          Icons.branding_watermark_rounded,
                          color: kPrimaryColor,
                        )),
                  ),
                ),
                kHeight20,
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(12),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                    value: selectedBrand,
                    items: widget.brandOptions
                        .map<DropdownMenuItem<String>>((BrandModel value) {
                      return DropdownMenuItem<String>(
                        value: value.brandName,
                        child: Text(value.brandName!),
                      );
                    }).toList(),
                    onChanged: (value) async {
                      setState(() {
                        selectedBrand = value;
                      });
                    },
                  ),
                ),
                kHeight20,
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(12),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: priceController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        labelText: 'Enter the price',
                        labelStyle: const TextStyle(color: kSecondaryColor),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(
                          Icons.money,
                          color: kPrimaryColor,
                        )),
                  ),
                ),
                kHeight20,
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(12),
                  child: TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        labelText: 'Enter the description',
                        labelStyle: const TextStyle(color: kSecondaryColor),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(
                          Icons.description_outlined,
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
                          loadingAnimation();
                          await addProductFunc();
                          imageController.imageList = [];
                          imageController.selectedIndex = null;
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          snack(context,
                              message:
                                  '${productNameController.text} successfully added',
                              color: Colors.green);
                        },
                        child: const Text(
                          'Add Product',
                          style: TextStyle(color: kwhite),
                        ))),
              ],
            ),
          ),
        ));
  }

  Future<void> addProductFunc() async {
    final imageUrl1 = await AddBrandService().imgUpload(image1!);
    final imageUrl2 = await AddBrandService().imgUpload(image2!);
    final imageUrl3 = await AddBrandService().imgUpload(image3!);
    ProductModel model = ProductModel(
        productImg1: imageUrl1,
        productImg2: imageUrl2,
        productImg3: imageUrl3,
        productName: productNameController.text,
        productBrand: selectedBrand!,
        productPrice: priceController.text,
        productDescription: descriptionController.text);
    await ProductService().addProduct(model);
  }
}
