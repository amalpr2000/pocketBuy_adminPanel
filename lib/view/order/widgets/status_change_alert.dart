import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy_admin/controller/dropdown_controller.dart';
import 'package:pocketbuy_admin/core/constants.dart';
import 'package:pocketbuy_admin/service/order_service.dart';

class StatusChangerPopup extends StatelessWidget {
  const StatusChangerPopup({super.key, required this.orderID, required this.ctx});
  final String orderID;
  final BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    var controllermain = DropdownController(item: statusList, value: statusList[0]);
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      title: Text(
        'Change Status',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      contentPadding:
          EdgeInsets.symmetric(horizontal: displayWidth * 0.1, vertical: displayHeight * 0.01),
      content: GetBuilder<DropdownController>(
          init: DropdownController(item: statusList, value: statusList[0]),
          builder: (controller) {
            controllermain = controller;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Status',
                ),
                DropdownButton(
                  value: controller.value,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: displayHeight * 0.08,
                  items: controller.item.map(
                    (String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    controller.selectItem(value!);
                  },
                )
              ],
            );
          }),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              String selectedChange = controllermain.value;
              Navigator.pop(context);
              confirmation(selectedChange: selectedChange, orderID: orderID);
            },
            child: const Text('Change'))
      ],
    );
  }

  confirmation({required String selectedChange, required String orderID}) {
    String key = keyFinder(selectedChange);
    showDialog(
      context: ctx,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.red),
            Text(
              'Attention',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content:
            const Text('Are you sure to proceed ,Because once you updated it cannot be undone'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              OrderService()
                  .updateStatus(key: key, orderId: orderID, currentStatus: selectedChange);
            },
            child: Text(
              'Update',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  String keyFinder(String value) {
    switch (value) {
      case 'Order Placed':
        return 'orderPlacedDate';
      case 'Order Shipped':
        return 'shippingDate';
      case 'Out For Delivery':
        return 'outForDeliveryDate';
      case 'Order Delivered':
        return 'deliveryDate';
      default:
        return '';
    }
  }
}
