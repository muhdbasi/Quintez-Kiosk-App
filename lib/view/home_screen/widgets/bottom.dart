import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quintez_kiosk_app/controller/menu_provider.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback onPressed;
  final String text;
  final Size size;

  const CustomButton({
    Key? key,
    required this.height,
    required this.width,
    required this.onPressed,
    required this.text,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<MenuProvider>(
            builder: (context, value, child) => InkWell(
              onTap: value.cartItems.isEmpty
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(15.0),
                          elevation: 6.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          content: Text(
                            'Please add atleast one product for checkout',
                            style: TextStyle(fontSize: size.height * 0.025),
                          ),
                        ),
                      );
                    }
                  : onPressed,
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
                height: height,
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: size.height * 0.02,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Consumer<MenuProvider>(
                      builder: (context, value, child) => Badge(
                        alignment: Alignment.topRight,
                        label: Text(
                          value.cartItems.length.toString(),
                        ),
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.green,
                          size: size.height * 0.03,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Text(
          "00.00",
          style: TextStyle(
            fontSize: size.height * 0.03,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
