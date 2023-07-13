import 'package:flutter/material.dart';
import 'package:pocketbuy_admin/core/colors.dart';
import 'package:pocketbuy_admin/core/constants.dart';

class AddBrand extends StatelessWidget {
  const AddBrand({super.key});

  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: const Text('Add Brand'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: kSecondaryColor,
                    border: Border.all(color: kSecondaryColor),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Add Image',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              kHeight40,
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(12),
                child: TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 0.0),
                      ),
                      labelText: 'Enter the brand name',
                      labelStyle: const TextStyle(color: kSecondaryColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(
                        Icons.branding_watermark_rounded,
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
                      onPressed: () {},
                      child: const Text(
                        'Add Brand',
                        style: TextStyle(color: kwhite),
                      ))),
            ],
          ),
        ));
  }
}
