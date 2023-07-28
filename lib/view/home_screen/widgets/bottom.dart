import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quintez_kiosk_app/controller/menu_provider.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:quintez_kiosk_app/view/checkout_screen/checkout_screen.dart';

class CustomButton extends StatefulWidget {
  final double height;
  final double width;
  final String text;

  const CustomButton({
    Key? key,
    required this.height,
    required this.width,
    required this.text,
    required Null Function() onPressed,
  }) : super(key: key);

  @override
  CustomButtonState createState() => CustomButtonState();
}

class CustomButtonState extends State<CustomButton> {
  late Timer _timer;
  int _secondsLeft = 1 * 04;

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
        Navigator.of(context).pop();
      }
    });
  }

  void _cancelTimer() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TimerBuilder.periodic(
          const Duration(seconds: 1), // Update every second
          builder: (context) {
            return Text(
              '${(_secondsLeft ~/ 60).toString().padLeft(2, '0')}:${(_secondsLeft % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              _cancelTimer(); // Stop the timer when the button is tapped
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CheckOutScreen(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2.0,
                    blurRadius: 6.0,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              height: widget.height,
              width: widget.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.text,
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Consumer<MenuProvider>(
                    builder: (context, value, child) => Badge(
                      label: Text(
                        value.cartItems.length.toString(),
                      ),
                      child: const Icon(
                        Icons.shopping_cart,
                        color: Colors.green,
                        size: 35,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
