import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy_admin/core/colors.dart';
import 'package:pocketbuy_admin/core/constants.dart';

import 'package:pocketbuy_admin/utils/snackbar.dart';

class AllBanners extends StatelessWidget {
  const AllBanners({super.key});

  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: const Text('All Banners'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('pocketBuy')
                .doc('admin')
                .collection('banners')
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
                    childAspectRatio: (1 / .285),
                    crossAxisCount: 1,
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
                          height: displayHeight * 0.13,
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
                                  height: displayHeight * 0.13,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(snapshot
                                              .data!.docs[index]['imageUrl']))),
                                ),
                                Positioned(
                                  top: displayHeight * 0.04,
                                  left: displayWidth * 0.74,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[300],
                                    child: IconButton(
                                        onPressed: () async {
                                          try {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                titlePadding: EdgeInsets.only(
                                                    left: 90,
                                                    right: 90,
                                                    top: 20),
                                                title: Text('Are you Sure ?'),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                        'This will delete the banner'),
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
                                                            onPressed:
                                                                () async {
                                                              Get.back();
                                                              snack(context,
                                                                  message:
                                                                      'Banner deleted successfully',
                                                                  color: Colors
                                                                      .red);
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'pocketBuy')
                                                                  .doc('admin')
                                                                  .collection(
                                                                      'banners')
                                                                  .doc(snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .id)
                                                                  .delete();
                                                            },
                                                            child: Text(
                                                                'Continue'))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                            // Get.defaultDialog(
                                            //   title: 'Are you sure?',
                                            //   middleText:
                                            //       'Do you really want to delete this banner?',
                                            //   onCancel: () =>
                                            //       Navigator.of(context).pop(),
                                            //   textConfirm: 'Yes',
                                            //   textCancel: 'No',
                                            //   radius: 12,
                                            //   onConfirm: () async {
                                            //     snack(context,
                                            //         message:
                                            //             'Banner deleted successfully',
                                            //         color: Colors.red);
                                            //     return await FirebaseFirestore
                                            //         .instance
                                            //         .collection('pocketBuy')
                                            //         .doc('admin')
                                            //         .collection('banners')
                                            //         .doc(snapshot
                                            //             .data!.docs[index].id)
                                            //         .delete();
                                            //   },
                                            // );
                                          } catch (error) {
                                            print(
                                                'Failed to delete banner: $error');
                                          }
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                  ),
                                ),
                              ]),
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
