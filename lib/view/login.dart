import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbuy_admin/core/colors.dart';
import 'package:pocketbuy_admin/core/constants.dart';
import 'package:pocketbuy_admin/utils/snackbar.dart';
import 'package:pocketbuy_admin/view/home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  kHeight20,
                  const Text(
                    'Welcome',
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  kHeight20,
                  const Text(
                    'Sign in with your email and password \n continue with social media ',
                    style: TextStyle(color: kSecondaryColor),
                    textAlign: TextAlign.center,
                  ),
                  kHeight40,
                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(12),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'this field is required';
                        } else {
                          return null;
                        }
                      },
                      controller: _emailController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 0.0),
                          ),
                          labelText: 'Enter your email',
                          labelStyle: const TextStyle(color: kSecondaryColor),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          suffixIcon: const Icon(Icons.mail_outline_rounded)),
                    ),
                  ),
                  kHeight40,
                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(12),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'this field is required';
                        } else {
                          return null;
                        }
                      },
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.amber),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 0.0),
                          ),
                          labelText: 'Enter your password',
                          labelStyle: const TextStyle(color: kSecondaryColor),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          suffixIcon: const Icon(Icons.lock_outline_rounded)),
                    ),
                  ),
                  // kHeight20,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: const [
                  //     Text(
                  //       'Forget password?',
                  //       style: TextStyle(color: kSecondaryColor),
                  //     ),
                  //   ],
                  // ),
                  kHeight40,
                  SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                          // style: ButtonStyle(backgroundColor: Colors.orange),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (_emailController.text == 'admin@gmail.com' &&
                                  _passwordController.text == 'admin') {
                                snack(context,
                                    message: 'Successfully logged in',
                                    color: Colors.green);

                                Get.off(HomeScreen());
                              } else {
                                snack(context,
                                    message:
                                        'Email and Password doesn\'t match',
                                    color: Colors.red);
                              }
                            } else {
                              snack(context,
                                  message: 'Fields cannot be empty',
                                  color: Colors.red);
                            }
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(color: kwhite),
                          ))),
                  kHeight40,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
