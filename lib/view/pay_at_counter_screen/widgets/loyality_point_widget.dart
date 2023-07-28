import 'package:flutter/material.dart';

class LoyalityPointWidget extends StatelessWidget {
  const LoyalityPointWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: size.width * 0.7,
        height: size.height * 0.15,
        decoration: BoxDecoration(
          color: const Color(0xFF08E5F1),
          boxShadow: [
            BoxShadow(
              offset: const Offset(
                0.3,
                0.3,
              ),
              color: Colors.grey.shade500,
              blurRadius: 5,
            ),
          ],
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your loyality points',
                    style: TextStyle(
                        shadows: [
                          BoxShadow(
                              offset: const Offset(0.5, 0.5),
                              color: Colors.grey.shade500,
                              blurRadius: 3),
                        ],
                        fontSize: size.height * 0.03,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '83',
                    style: TextStyle(
                      shadows: [
                        BoxShadow(
                            offset: const Offset(0.5, 0.5),
                            color: Colors.grey.shade500,
                            blurRadius: 3),
                      ],
                      fontSize: size.height * 0.03,
                      color: Colors.black,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: size.height * 0.05,
                    width: size.width * 0.3,
                    decoration: BoxDecoration(
                        color: Colors.orange.shade400,
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
                      'Redeem',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.035,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
