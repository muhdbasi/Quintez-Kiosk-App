import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quintez_kiosk_app/controller/menu_provider.dart';
import 'package:quintez_kiosk_app/view/checkout_screen/widgets/bottom_nav_widget.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

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
              size: size.width * 0.03,
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
                            //'https://images.pexels.com/photos/406152/pexels-photo-406152.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
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
                              style: TextStyle(fontSize: size.height * 0.03),
                            ),
                            SizedBox(
                              width: size.width * 0.46,
                              child: Text(
                                value.cartItems[index].description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: size.height * 0.025,
                                ),
                              ),
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
                                      child: Opacity(
                                        opacity:
                                            value.cartItems[index].quantity <= 1
                                                ? 0.25
                                                : 1,
                                        child: IconButton(
                                          icon: const Icon(Icons.remove),
                                          iconSize: size.height * 0.022,
                                          onPressed: value.cartItems[index]
                                                      .quantity <=
                                                  1
                                              ? () {}
                                              : () {
                                                  value
                                                      .decrementCartItemQuantity(
                                                          value.cartItems[index]
                                                              .productId);
                                                },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.height * 0.01,
                                ),
                                Text(
                                  value.cartItems[index].quantity.toString(),
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
                                        onPressed: () {
                                          value.incrementCartItemQuantity(
                                              value.cartItems[index].productId);
                                        },
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
                                  value
                                      .calculateTotalAmount(
                                          value.cartItems[index].quantity,
                                          value.cartItems[index].price)
                                      .toStringAsFixed(2),
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
                          padding: EdgeInsets.all(size.height * 0.01),
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
