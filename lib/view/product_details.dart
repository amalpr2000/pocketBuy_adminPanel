import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy_admin/core/colors.dart';
import 'package:pocketbuy_admin/core/constants.dart';
import 'package:pocketbuy_admin/model/brand_model.dart';
import 'package:pocketbuy_admin/service/add_brand_service.dart';
import 'package:pocketbuy_admin/service/product_service.dart';
import 'package:pocketbuy_admin/utils/snackbar.dart';
import 'package:pocketbuy_admin/view/edit_product.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({
    super.key,
    required this.productId,
  });

  String productId;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedImage = 1;
  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('pocketBuy')
            .doc('admin')
            .collection('products')
            .doc(widget.productId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Scaffold(
              appBar: AppBar(
                toolbarHeight: 80,
                actions: [
                  // IconButton(
                  //     onPressed: () async {
                  //       List<BrandModel> brandList =
                  //           await AddBrandService().getbrands();
                  //       Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => EditProduct(
                  //             brandOptions: brandList,
                  //             imgPath: snapshot.data!['productImg1'],
                  //             productName: snapshot.data!['productName'],
                  //             productDes: snapshot.data!['productDescription'],
                  //             productPrice: snapshot.data!['productPrice']),
                  //       ));
                  //     },
                  //     icon: Icon(Icons.edit)),
                  IconButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          titlePadding:
                              EdgeInsets.only(left: 90, right: 90, top: 20),
                          title: Text('Are you Sure ?'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('This will delete the product'),
                              kHeight20,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text('Cancel')),
                                  ElevatedButton(
                                      onPressed: () async {
                                        snack(context,
                                            message: 'Deleted',
                                            color: Colors.red);
                                        Get.back();
                                        Get.back();
                                        await ProductService().deleteProduct(
                                            snapshot.data!['productName']);
                                      },
                                      child: Text('Continue'))
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.delete),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 1.5,
                        child: Hero(
                          tag: "DemoTag",
                          child: Image.network(
                              snapshot.data!['productImg$selectedImage']),
                        ),
                      ),
                    ),
                    // SizedBox(height: getProportionateScreenWidth(20)),
                    kHeight10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                            3, (index) => buildSmallProductPreview(index)),
                      ],
                    ),
                    kHeight20,
                    Material(
                      elevation: 20,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      child: Container(
                        height: displayHeight * 0.445,
                        // margin: EdgeInsets.only(top: 20),
                        // padding: EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kHeight20,
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  snapshot.data!['productName'],
                                  style: TextStyle(fontSize: 22),
                                ),
                              ],
                            ),
                            kHeight20,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data!['productDescription']),
                                    kHeight20,
                                    Text(
                                      '₹ ${snapshot.data!['productPrice']}',
                                      style: TextStyle(
                                          fontSize: 22, color: kPrimaryColor),
                                    ),
                                    kHeight40,
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ));
        });
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index + 1;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 5),
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor
                  .withOpacity(selectedImage == index + 1 ? 1 : 0)),
        ),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('pocketBuy')
                .doc('admin')
                .collection('products')
                .doc(widget.productId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Image.network(snapshot.data!['productImg${index + 1}']);
            }),
      ),
    );
  }
}

List productimages = [
  'assets/images/14pro.jpg',
  'assets/images/14pro1.jpg',
  'assets/images/14pro2.jpg',
  'assets/images/14pro3.jpg',
  'assets/images/14pro4.jpg'
];
