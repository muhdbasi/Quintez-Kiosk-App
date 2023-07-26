import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  int selectedPaymentIndex = -1;

  // Sample payment methods data
  List<String> paymentMethodNames = [
    'Pay Using UPID',
    'Pay using card',
    'swiping card',
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    List<String> paymentMethodImages = [
      'https://cdn.iconscout.com/icon/free/png-256/free-upi-2085056-1747946.png',
      'https://static.thenounproject.com/png/2321924-200.png',
      'https://static.thenounproject.com/png/592537-200.png',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView.builder(
          itemCount: paymentMethodNames.length,
          itemBuilder: (context, index) {
            return Card(
              child: RadioListTile<int>(
                value: index,
                groupValue: selectedPaymentIndex,
                onChanged: (int? value) {
                  setState(() {
                    selectedPaymentIndex = value!;
                  });
                },
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: size.width * 0.30,
                          height: size.height * 0.1,
                          child: Image.network(
                            paymentMethodImages[index],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            paymentMethodNames[index],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            );
          },
        ),
      ),
    );
  }
}
