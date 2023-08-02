import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocketbuy_admin/controller/edit_img_controller.dart';
import 'package:pocketbuy_admin/core/colors.dart';
import 'package:pocketbuy_admin/core/constants.dart';
import 'package:pocketbuy_admin/model/brand_model.dart';
import 'package:pocketbuy_admin/model/product_model.dart';
import 'package:pocketbuy_admin/service/add_brand_service.dart';
import 'package:pocketbuy_admin/service/product_service.dart';
import 'package:pocketbuy_admin/utils/snackbar.dart';

class EditProduct extends StatefulWidget {
  EditProduct(
      {super.key,
      required this.brandOptions,
      required this.imgPath,
      required this.productName,
      required this.productDes,
      required this.productPrice});
  final List<BrandModel> brandOptions;
  String? imgPath;
  // String? brand;
  String productName;
  String? productDes;
  String? productPrice;

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  EditImgController editImg = EditImgController();

  late String? selectedBrand = widget.brandOptions[0].brandName;

  XFile? image1;

  XFile? image2;

  XFile? image3;
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productNameController.text = widget.productName;
    priceController.text = widget.productPrice!;
    descriptionController.text = widget.productDes!;
  }

  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    Future<void> editProductfunc() async {
      String? downloadImageUrl;
      if (editImg.pickedImg.isNotEmpty) {
        downloadImageUrl =
            await AddBrandService().imgUpload(XFile(editImg.pickedImg.value));
      } else {
        downloadImageUrl = widget.imgPath;
      }
      if (downloadImageUrl == null) {
        return;
      }
      ProductModel model = ProductModel(
          productBrand: selectedBrand!,
          productDescription: widget.productDes!,
          productImg1: widget.imgPath!,
          productImg2: widget.imgPath!,
          productImg3: widget.imgPath!,
          productName: widget.productName,
          productPrice: widget.productPrice!);

      await ProductService().deleteProduct(widget.productName);
      await ProductService().addProduct(model);
    }

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: const Text('Edit Product'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    editImg.changeImg();
                  },
                  child: Obx(
                    () => Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: kSecondaryColor,
                            border: Border.all(color: kSecondaryColor),
                            borderRadius: BorderRadius.circular(8)),
                        child: editImg.pickedImg.isEmpty
                            ? Image.network(widget.imgPath!)
                            : Image.file(File(editImg.pickedImg.value))),
                  ),
                ),
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
                      // setState(() {
                      selectedBrand = value;
                      // });
                    },
                  ),
                ),
                kHeight20,
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(12),
                  child: TextFormField(
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
                          await editProductfunc();
                          snack(context,
                              message:
                                  '${productNameController.text} edited successfully',
                              color: Colors.green);
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Update Product',
                          style: TextStyle(color: kwhite),
                        ))),
              ],
            ),
          ),
        ));
  }
}
