// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quintez_kiosk_app/controller/menu_provider.dart';
import 'package:quintez_kiosk_app/model/add_order_model.dart';
import 'package:quintez_kiosk_app/view/pay_at_counter_screen/pay_at_counter_screen.dart';
import 'package:quintez_kiosk_app/view/register_screen/register_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CheckingScreen extends StatelessWidget {
  CheckingScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final supaBase = Supabase.instance.client;
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16.0),
              Text(
                'Enter your mobile number',
                style: TextStyle(fontSize: size.width * 0.032),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 20,
                ),
                child: Form(
                  key: formKey,
                  child: SizedBox(
                    width: size.width * 0.55,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number.';
                        }

                        if (value.length != 10) {
                          return 'Mobile number should be 10 digits long.';
                        }

                        return null; // Return null to indicate the input is valid.
                      },
                      controller: phoneNumberController,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Mobile number',
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: size.width * 0.03),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.orange,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.phone_android,
                          color: Colors.green,
                          size: size.height * 0.028,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   width: size.width * 0.55,
              //   child: TextFormField(
              //     // validator: (value) {
              //     //   if (value == null || value.isEmpty) {
              //     //     return 'Please enter your mobile number.';
              //     //   }

              //     //   if (value.length != 10) {
              //     //     return 'Mobile number should be 10 digits long.';
              //     //   }

              //     //   return null; // Return null to indicate the input is valid.
              //     // },
              //     // controller: phoneNumberController,
              //     maxLength: 6,
              //     keyboardType: TextInputType.number,
              //     decoration: InputDecoration(
              //       hintText: 'OTP',
              //       hintStyle: TextStyle(
              //           color: Colors.grey, fontSize: size.width * 0.03),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(8),
              //         borderSide: const BorderSide(
              //           color: Colors.orange,
              //         ),
              //       ),
              //       prefixIcon: Icon(
              //         Icons.message_sharp,
              //         color: Colors.green,
              //         size: size.height * 0.028,
              //       ),
              //     ),
              //   ),
              // ),
              Consumer<MenuProvider>(
                builder: (context, value, child) => SizedBox(
                  width: size.width * 0.45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () async {
                          bool customerFound = false;
                          if (formKey.currentState!.validate()) {
                            customerFound = await value.checkCustomer(
                              int.parse(phoneNumberController.text.trim()),
                            );

                            if (!customerFound) {
                              await supaBase.auth
                                  .signInWithOtp(
                                    phone: "+91${phoneNumberController.text}",
                                    shouldCreateUser: true,
                                  )
                                  .whenComplete(
                                    () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => RegisterScreen(
                                          mobileNo:
                                              phoneNumberController.text.trim(),
                                        ),
                                      ),
                                    ),
                                  );
                            } else {
                              try {
                                AddOrderModel addOrderModel =
                                    await value.addToOrdersItem(
                                  value.cartItems,
                                  value.calculateSubtotal(),
                                  0,
                                  int.parse(phoneNumberController.text.trim()),
                                );

                                if (addOrderModel.success) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PayAtCounterScreen(
                                        totalAmount: value.calculateSubtotal(),
                                      ),
                                    ),
                                  );
                                }
                              } catch (e) {
                                log("show dialoge Error $e");
                              }
                            }
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: size.width * 0.035,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
