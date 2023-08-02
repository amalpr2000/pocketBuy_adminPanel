import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy_admin/core/constants.dart';
import 'package:pocketbuy_admin/utils/snackbar.dart';

class AllBrands extends StatelessWidget {
  const AllBrands({super.key});

  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: const Text('All Brands'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('pocketBuy')
                .doc('admin')
                .collection('brands')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return GridView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Material(
                      elevation: 7,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          // margin: EdgeInsets.all(0),
                          // elevation: 5,
                          // height: 600,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(children: [
                                Container(
                                  height: 125,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(snapshot
                                              .data!.docs[index]['brandImg']))),
                                ),
                                Positioned(
                                  left: displayWidth * 0.26,
                                  child: IconButton(
                                      onPressed: () async {
                                        try {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              titlePadding: EdgeInsets.only(
                                                  left: 90, right: 90, top: 20),
                                              title: Text('Are you Sure ?'),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                      'This will delete the brand'),
                                                  kHeight20,
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child:
                                                              Text('Cancel')),
                                                      ElevatedButton(
                                                          onPressed: () async {
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'pocketBuy')
                                                                .doc('admin')
                                                                .collection(
                                                                    'brands')
                                                                .doc(snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .id)
                                                                .delete();
                                                            snack(context,
                                                                message:
                                                                    'Brand deleted successfully',
                                                                color:
                                                                    Colors.red);
                                                            Get.back();
                                                          },
                                                          child:
                                                              Text('Continue'))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                          // Get.defaultDialog(

                                          //   title: 'Are you sure?',
                                          //   middleText:
                                          //       'Do you really want to delete this brand?',
                                          //   onCancel: () => Get.back(),
                                          //   textConfirm: 'Yes',
                                          //   textCancel: 'No',
                                          //   radius: 12,
                                          //   onConfirm: () async {
                                          //     await FirebaseFirestore.instance
                                          //         .collection('pocketBuy')
                                          //         .doc('admin')
                                          //         .collection('brands')
                                          //         .doc(snapshot
                                          //             .data!.docs[index].id)
                                          //         .delete();
                                          //     snack(context,
                                          //         message:
                                          //             'Brand deleted successfully',
                                          //         color: Colors.red);
                                          //   },
                                          // );
                                        } catch (error) {
                                          print(
                                              'Failed to delete category: $error');
                                        }
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ),
                              ]),
                              Text(snapshot.data!.docs[index]['brandName']),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ));
  }
}
