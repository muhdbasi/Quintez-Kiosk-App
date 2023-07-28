import 'package:flutter/material.dart';
import 'package:quintez_kiosk_app/view/pay_at_counter_screen/widgets/bill_container_widget.dart';

class PayAtCounterScreen extends StatelessWidget {
  final double totalAmount;
  const PayAtCounterScreen({
    super.key,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_dining_outlined,
              size: size.width * 0.04,
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Text(
              'Bill',
              style:
                  TextStyle(fontSize: size.width * 0.035, letterSpacing: 1.5),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.18,
          ),
          BillContainerWidget(
            size: size,
            totalAmount: totalAmount,
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              alignment: Alignment.center,
              width: size.width,
              height: size.height * 0.03,
              decoration: BoxDecoration(
                color: Colors.red.shade200,
                borderRadius: BorderRadius.circular(
                  5,
                ),
              ),
              child: Text(
                "Note : This order isn't confirmed yet! go to the counter for pay",
                style: TextStyle(fontSize: size.height * 0.02),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        width: size.width,
        height: size.height * 0.1,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
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
                    fontSize: size.width * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.06,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                    color: Colors.blue.shade400,
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
                  'Print',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.04,
                    color: Colors.white,
                    letterSpacing: 1.5,
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
