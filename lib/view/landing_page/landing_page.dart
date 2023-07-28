import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quintez_kiosk_app/controller/menu_provider.dart';
import 'package:quintez_kiosk_app/view/home_screen/home_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: size.height * 0.06,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                      color: const Color(0xFF2B3663),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
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
                      ]),
                  child: Text(
                    'Order',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.04,
                        color: Colors.white,
                        letterSpacing: 1.5),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InkWell(
                onTap: () {
                  Provider.of<MenuProvider>(context, listen: false)
                      .checkCustomer(1234567892);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: size.height * 0.06,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                    color: const Color(0xFF609F08),
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(1, 1),
                          color: Colors.grey.shade500,
                          blurRadius: 3),
                      BoxShadow(
                          offset: const Offset(-0.5, -0.5),
                          color: Colors.grey.shade500,
                          blurRadius: 3),
                    ],
                  ),
                  child: Text(
                    'Order status',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.04,
                        color: Colors.white,
                        letterSpacing: 1.5),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
