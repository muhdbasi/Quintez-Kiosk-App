import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quintez_kiosk_app/controller/menu_provider.dart';
import 'package:quintez_kiosk_app/view/checkout_screen/widgets/bottom_nav_widget.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({
    super.key,
  });

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  bool timerStopped = true;
  void startTimer() {
    setState(() {
      timerStopped = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
          onPressed: () {
            startTimer();
            Navigator.of(context)
                .pop(); // Go back when the back button is pressed
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://logodownload.org/wp-content/uploads/2017/10/starbucks-logo-1.png',
              width: size.width * 0.09,
              height: size.width * 0.08,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Text(
              'Checkout',
              style: TextStyle(fontSize: size.width * 0.03, letterSpacing: 1.5),
            ),
          ],
        ),
      ),
      body: Consumer<MenuProvider>(
        builder: (context, value, child) => ListView.builder(
          itemCount: value.cartItems.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.height * 0.02,
                vertical: size.height * 0.01,
              ),
              child: Container(
                width: size.width,
                height: size.height * 0.18,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0.3, 0.3),
                        color: Colors.grey.shade500,
                        blurRadius: 5,
                      )
                    ]),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: size.width * 0.33,
                          height: size.height * 0.18,
                          child: Image.network(
                            value.cartItems[index].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.height * 0.015,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: FittedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              value.cartItems[index].productName,
                              style: const TextStyle(fontSize: 28),
                            ),
                            Text(
                              value.cartItems[index].description,
                              style: const TextStyle(fontSize: 28),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(
                                            1,
                                            1,
                                          ),
                                          color: Colors.grey.shade400,
                                          blurRadius: 10,
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: CircleAvatar(
                                    backgroundColor: const Color(0xFF609F08)
                                        .withOpacity(0.5),
                                    radius: 25,
                                    child: Center(
                                      child: IconButton(
                                        icon: const Icon(Icons.remove),
                                        iconSize: size.height * 0.022,
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.height * 0.01,
                                ),
                                Text(
                                  '1',
                                  style:
                                      TextStyle(fontSize: size.height * 0.02),
                                ),
                                SizedBox(
                                  width: size.height * 0.01,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(
                                            1,
                                            1,
                                          ),
                                          color: Colors.grey.shade400,
                                          blurRadius: 10,
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: CircleAvatar(
                                    backgroundColor: const Color(0xFF609F08)
                                        .withOpacity(0.5),
                                    radius: 25,
                                    child: Center(
                                      child: IconButton(
                                        icon: const Icon(Icons.add),
                                        iconSize: size.height * 0.022,
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  '\$450',
                                  style: TextStyle(
                                      fontSize: 28,
                                      decoration: TextDecoration.lineThrough),
                                ),
                                SizedBox(
                                  width: size.height * 0.01,
                                ),
                                Text(
                                  value.cartItems[index].price.toString(),
                                  style: const TextStyle(
                                    fontSize: 28,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(size.height * 0.02),
                          child: IconButton(
                            onPressed: () {
                              value.removeFromCart(
                                  value.cartItems[index].productId);
                            },
                            icon: Icon(
                              Icons.delete,
                              size: size.height * 0.03,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        size: size,
      ),
    );
  }
}
