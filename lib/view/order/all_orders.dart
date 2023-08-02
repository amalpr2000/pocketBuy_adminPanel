import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy_admin/core/colors.dart';
import 'package:pocketbuy_admin/model/order_model.dart';
import 'package:pocketbuy_admin/view/order/orderstatus.dart';

class AllOrders extends StatelessWidget {
  const AllOrders({super.key});

  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    var orderInstance = FirebaseFirestore.instance.collection('order');
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: const Text('All Orders'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: StreamBuilder(
              stream: orderInstance.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: Text('Data is empty'),
                  );
                }

                return ListView.separated(
                    itemBuilder: (context, index) {
                      OrderModel order = OrderModel.fromMap(snapshot.data!.docs[index]);
                      return ListTile(
                        onTap: () =>
                            Get.to(() => OrderDetails(orderId: snapshot.data!.docs[index].id)),
                        title: Text(order.cartlist!.length > 1
                            ? 'Order id: ${snapshot.data!.docs[index].id}'
                            : order.cartlist![0].name!),
                        subtitle: Text(
                          order.orderStatus!,
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        leading: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(order.cartlist![0].imageLink!))),
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
                    itemCount: snapshot.data!.docs.length);
              }),
        ));
  }
}
