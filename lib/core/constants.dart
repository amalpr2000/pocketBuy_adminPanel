import 'package:flutter/material.dart';

SizedBox kHeight10 = const SizedBox(height: 10);
SizedBox kHeight20 = const SizedBox(height: 20);
SizedBox kHeight40 = const SizedBox(height: 40);
sizedboxwithheight(double? height) {
  return SizedBox(
    height: height,
  );
}


const List<String> statusList = [
      'Order Placed',
      'Order Shipped',
      'Out For Delivery',
      'Order Delivered',
    ];