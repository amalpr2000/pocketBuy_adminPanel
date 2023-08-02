
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderService {
  updateStatus(
      {required String key,
      required String orderId,
   
      required String currentStatus}) async {
    try {
      var data = await FirebaseFirestore.instance.collection('order').doc(orderId).get();
      
      if (data[key] == 'Not setted') {
        String date = DateTime.now().toString();

        await FirebaseFirestore.instance.collection('order')
            .doc(orderId)
            .update({key: date, 'orderStatus': currentStatus}).then((value) {
          // Navigator.of(context).pop();
          // showDialog(
          //   context: context,
          //   builder: (context) => AlertDialog(
          //     content: Text('Successfully updated'),
          //     actions: [
          //       TextButton(
          //           onPressed: () {
          //             Navigator.of(context).pop();
          //           },
          //           child: Text('Ok'))
          //     ],
          //   ),
          // );
        });
      } else {
        
      }
    } on FirebaseException catch (e) {
      // alertshower(context: context, e: e.message.toString());
    }
  }

 
}
