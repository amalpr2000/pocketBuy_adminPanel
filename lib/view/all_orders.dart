import 'package:flutter/material.dart';
import 'package:pocketbuy_admin/core/colors.dart';

class AllOrders extends StatelessWidget {
  const AllOrders({super.key});

  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: const Text('All Orders'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Apple iphone 14 Pro'),
                  subtitle: Text(
                    'Order Placed',
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
                            image: AssetImage('assets/images/14pro.jpg'))),
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
              itemCount: 20),
        ));
  }
}
