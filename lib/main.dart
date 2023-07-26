import 'package:flutter/material.dart';
import 'package:quintez_kiosk_app/view/home_screen/home_screen.dart';

import 'view/payment_screen/payment_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const PaymentScreen(),
    );
  }
}
