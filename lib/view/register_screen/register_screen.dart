// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:quintez_kiosk_app/controller/menu_provider.dart';
import 'package:quintez_kiosk_app/model/add_order_model.dart';
import 'package:quintez_kiosk_app/view/pay_at_counter_screen/pay_at_counter_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterScreen extends StatelessWidget {
  final String mobileNo;
  RegisterScreen({
    super.key,
    required this.mobileNo,
  });

  final formKey = GlobalKey<FormState>();
  final supaBase = Supabase.instance.client;
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: size.height * 0.02),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Enter your OTP here',
                style: TextStyle(fontSize: 26),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 20,
              ),
              child: Consumer<MenuProvider>(
                builder: (context, valueProvider, child) => PinCodeTextField(
                  appContext: context,
                  length: 6,
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  onCompleted: (value) {
                    otpController.text = value;
                  },
                  validator: (value) {
                    if (otpController.text.isEmpty ||
                        otpController.text.length < 6) {
                      return 'Please fill the OTP';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    verifyOtp(mobileNo, supaBase, context, valueProvider);
                  },
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15),
            //   child: CustomButton(
            //       height: size.height * 0.07,
            //       width: size.width,
            //       onPressed: () {
            //         // await supaBase.auth.signOut();
            //       },
            //       text: 'Next'),
            // ),
            SizedBox(
              height: size.height * 0.01,
            ),
            const Center(
              child: Text(
                'Terms and conditions',
                style: TextStyle(
                    fontSize: 15, decoration: TextDecoration.underline),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.privacy_tip_outlined,
                  size: size.width * 0.04,
                  color: Colors.black,
                ),
                const Text(
                  'Privacy and policy',
                  style: TextStyle(
                      fontSize: 15, decoration: TextDecoration.underline),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Didn't recieve OTP?",
                    style: TextStyle(fontSize: 16, letterSpacing: 1)),
                Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Text(
                    "Resend OTP",
                    style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                        color: Colors.redAccent),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  verifyOtp(String mobile, supaBase, context, MenuProvider value) async {
    try {
      final AuthResponse res = await supaBase.auth.verifyOTP(
          token: otpController.text, type: OtpType.sms, phone: '+91$mobile');
      await value.addToCustomerList(int.parse(mobileNo));

      if (res.user!.id.isNotEmpty) {
        bool customerFound = false;
        if (formKey.currentState!.validate()) {
          customerFound = await value.checkCustomer(
            int.parse(mobile),
          );

          if (!customerFound) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RegisterScreen(
                  mobileNo: mobileNo,
                ),
              ),
            );
          } else {
            try {
              AddOrderModel addOrderModel = await value.addToOrdersItem(
                value.cartItems,
                value.calculateSubtotal(),
                0,
                int.parse(mobileNo),
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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red.shade800,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(15.0),
            elevation: 6.0,
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            content: const Text('Otp is incorrect'),
          ),
        );
      }
      log(res.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
