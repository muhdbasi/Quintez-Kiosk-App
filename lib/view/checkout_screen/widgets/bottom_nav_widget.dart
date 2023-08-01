import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quintez_kiosk_app/controller/menu_provider.dart';
import 'package:quintez_kiosk_app/view/pay_at_counter_screen/pay_at_counter_screen.dart';
import 'package:quintez_kiosk_app/view/payment_screen/payment_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: size.height * 0.2,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                color: Colors.white,
                width: size.width * 0.15,
                height: size.width * 0.07,
                child: Text(
                  '00:00',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: size.width * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: size.width * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' - ',
                      style: TextStyle(fontSize: size.width * 0.035),
                    ),
                    Consumer<MenuProvider>(
                      builder: (context, value, child) => Text(
                        "\$ ${value.calculateSubtotal().toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: size.width * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  showDialogue(context, size);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: size.height * 0.06,
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2B3663),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1, 1),
                        color: Colors.grey.shade400,
                        blurRadius: 3,
                      ),
                      BoxShadow(
                        offset: const Offset(-0.5, -0.5),
                        color: Colors.grey.shade400,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Text(
                    'Loyality points',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.035,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Consumer<MenuProvider>(
                builder: (context, value, child) => InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PayAtCounterScreen(
                            totalAmount: value.calculateSubtotal()),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: size.height * 0.06,
                    width: size.width * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade700,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(1, 1),
                          color: Colors.grey.shade400,
                          blurRadius: 3,
                        ),
                        BoxShadow(
                          offset: const Offset(-0.5, -0.5),
                          color: Colors.grey.shade400,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: Text(
                      'Pay at counter',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.035,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PaymentScreen(),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: size.height * 0.06,
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    color: const Color(0xFF609F08),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1, 1),
                        color: Colors.grey.shade400,
                        blurRadius: 3,
                      ),
                      BoxShadow(
                        offset: const Offset(-0.5, -0.5),
                        color: Colors.grey.shade400,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Text(
                    'Pay now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.035,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  showRedeemDialogue(context, size);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: size.height * 0.06,
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1, 1),
                        color: Colors.grey.shade500,
                        blurRadius: 3,
                      ),
                      BoxShadow(
                        offset: const Offset(-0.5, -0.5),
                        color: Colors.grey.shade400,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Text(
                    'Redeem points',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.035,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.06,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  color: Colors.purple.shade400,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(1, 1),
                      color: Colors.grey.shade400,
                      blurRadius: 3,
                    ),
                    BoxShadow(
                      offset: const Offset(-0.5, -0.5),
                      color: Colors.grey.shade400,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Text(
                  'Apply coupon',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.035,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Future<void> showDialogue(BuildContext context, Size size) {
    final formKey = GlobalKey<FormState>();
    final supaBase = Supabase.instance.client;
    TextEditingController phoneNumberController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16.0),
                Text(
                  'Enter your mobile number for loyality',
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
                SizedBox(
                  width: size.width * 0.55,
                  child: TextFormField(
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter your mobile number.';
                    //   }

                    //   if (value.length != 10) {
                    //     return 'Mobile number should be 10 digits long.';
                    //   }

                    //   return null; // Return null to indicate the input is valid.
                    // },
                    // controller: phoneNumberController,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'OTP',
                      hintStyle: TextStyle(
                          color: Colors.grey, fontSize: size.width * 0.03),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.orange,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.message_sharp,
                        color: Colors.green,
                        size: size.height * 0.028,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await supaBase.auth.signInWithOtp(
                              phone: "+91${phoneNumberController.text}",
                              shouldCreateUser: true,
                            );
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
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showRedeemDialogue(BuildContext context, Size size) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16.0),
                Text(
                  'You currently have ${0} points',
                  style: TextStyle(fontSize: size.width * 0.032),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: size.width * 0.45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Close',
                          style: TextStyle(
                            fontSize: size.width * 0.035,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      // TextButton(
                      //   onPressed: () {
                      //     Navigator.of(context).pop();
                      //   },
                      //   child: Text(
                      //     'Redeem',
                      //     style: TextStyle(
                      //       fontSize: size.width * 0.035,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.green.shade900,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
