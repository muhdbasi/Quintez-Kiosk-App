import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BillContainerWidget extends StatelessWidget {
  final double totalAmount;
  const BillContainerWidget({
    super.key,
    required this.size,
    required this.totalAmount,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.height * 0.025,
          vertical: size.height * 0.01,
        ),
        child: Container(
          width: size.width * 0.7,
          height: size.height * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10,
            ),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(
                    0.3,
                    0.3,
                  ),
                  color: Colors.grey.shade600,
                  blurRadius: 5),
            ],
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.height * 0.02,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    thickness: 1.5,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(
                        fontSize: size.height * 0.022,
                      ),
                    ),
                    Text(
                      getFormattedDate(DateTime.now()),
                      style: TextStyle(
                        fontSize: size.height * 0.022,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Id - ',
                      style: TextStyle(
                        fontSize: size.height * 0.022,
                      ),
                    ),
                    Text(
                      ' 1254363581',
                      style: TextStyle(
                        fontSize: size.height * 0.022,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Taxes - ',
                      style: TextStyle(
                        fontSize: size.height * 0.022,
                      ),
                    ),
                    Text(
                      ' \$12',
                      style: TextStyle(
                        fontSize: size.height * 0.022,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Amount to Pay - ',
                      style: TextStyle(
                        fontSize: size.height * 0.022,
                      ),
                    ),
                    Text(
                      totalAmount.toString(),
                      style: TextStyle(
                        fontSize: size.height * 0.022,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    thickness: 1.5,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
                child: Text(
                  'Thank You',
                  style: TextStyle(
                    fontSize: size.height * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getFormattedDate(DateTime date) {
    final formattedDate = DateFormat('dd-MM-yyyy').format(date);
    return formattedDate;
  }
}
