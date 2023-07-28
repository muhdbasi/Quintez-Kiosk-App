import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quintez_kiosk_app/view/pay_at_counter_screen/pay_at_counter_screen.dart';
import 'package:quintez_kiosk_app/view/payment_screen/payment_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late Timer _timer;
  int _secondsLeft = 1 * 60; // 1 minute (60 seconds)

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        setState(() {
          _secondsLeft--;
        });
      } else {
        _cancelTimer(); // Stop the timer when it reaches 0
        // Add your code here when the timer reaches 0, e.g., show an alert, navigate to a new screen, etc.
        // For now, let's print a message.
        print("Timer reached 0!");
      }
    });
  }

  void _cancelTimer() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: widget.size.height * 0.2,
      width: widget.size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                color: Colors.white,
                width: widget.size.width * 0.15,
                height: widget.size.width * 0.07,
                child: Text(
                  '${(_secondsLeft ~/ 60).toString().padLeft(2, '0')}:${(_secondsLeft % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: widget.size.width * 0.035,
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
                        fontSize: widget.size.width * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' - ',
                      style: TextStyle(fontSize: widget.size.width * 0.035),
                    ),
                    Text(
                      "\$500",
                      style: TextStyle(
                        fontSize: widget.size.width * 0.035,
                        fontWeight: FontWeight.bold,
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
                  showDialogue(context, widget.size);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: widget.size.height * 0.06,
                  width: widget.size.width * 0.3,
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
                    'Loyalty points',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: widget.size.width * 0.035,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _cancelTimer();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PayAtCounterScreen(),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: widget.size.height * 0.06,
                  width: widget.size.width * 0.3,
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
                      fontSize: widget.size.width * 0.035,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _cancelTimer();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PaymentScreen(),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: widget.size.height * 0.06,
                  width: widget.size.width * 0.3,
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
                      fontSize: widget.size.width * 0.035,
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
                  _cancelTimer();
                  showRedeemDialogue(context, widget.size);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: widget.size.height * 0.06,
                  width: widget.size.width * 0.3,
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
                      fontSize: widget.size.width * 0.035,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: widget.size.height * 0.06,
                width: widget.size.width * 0.3,
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
                    fontSize: widget.size.width * 0.035,
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
                  'Enter your mobile number for loyalty',
                  style: TextStyle(fontSize: size.width * 0.032),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 20,
                  ),
                  child: SizedBox(
                    width: size.width * 0.55,
                    child: TextFormField(
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
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
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
