import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy_admin/core/colors.dart';
import 'package:pocketbuy_admin/view/add_brand.dart';
import 'package:pocketbuy_admin/view/add_product.dart';
import 'package:pocketbuy_admin/view/all_brands.dart';
import 'package:pocketbuy_admin/view/all_orders.dart';
import 'package:pocketbuy_admin/view/all_product.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text('Admin Panel'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  if (index == 0) {
                    Get.to(() => AllProducts());
                  } else if (index == 1) {
                    Get.to(() => AllBrands());
                  } else if (index == 2) {
                    Get.to(() => AddBrand());
                  } else if (index == 3) {
                    Get.to(() => AddProduct());
                  } else if (index == 4) {
                    Get.to(() => AllOrders());
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                tileColor: Colors.grey[100],
                title: Text(menuTitle[index]),
                leading: Icon(
                  menuIcon[index],
                  size: 30,
                  color: kPrimaryColor,
                ),
                trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: kSecondaryColor,
                    )),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: 15,
                ),
            itemCount: menuTitle.length),
      ),
    );
  }
}

List menuTitle = [
  'All Products',
  'All Brands',
  'Add Brand',
  'Add Product',
  'All Orders',
];
List menuIcon = [
  Icons.store_rounded,
  Icons.branding_watermark_rounded,
  Icons.add_shopping_cart_rounded,
  Icons.add_business_rounded,
  Icons.wallet,
];
