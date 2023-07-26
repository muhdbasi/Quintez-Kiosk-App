import 'package:flutter/material.dart';
import 'package:quintez_kiosk_app/view/home_screen/widgets/bottom.dart';

import 'widgets/menu_options.dart';
import 'widgets/grid_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: Stack(
        children: [
          Positioned.fill(
            child: Row(
              children: [
                // Side with "Breakfast" options (Green Container)
                Flexible(
                  flex: 4,
                  child: Container(
                    color: Colors.white70,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 12,
                    ),
                    child: const MenuOptions(),
                  ),
                ),
                // Side with GridView (Scrollable Column)
                Expanded(
                  flex: 15,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          // Grid view of products
                          SizedBox(
                            height: size.height * 0.9,
                            width: size.width,
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: productList.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: ProductGridview(
                                      product: productList[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.green,
        child: CustomButton(
            height: 50, width: 250, onPressed: () {}, text: "text"),
      ),
    );
  }
}

class Product {
  final String name;
  final String imageUrl;
  final double price;
  final double offerPrice;

  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.offerPrice,
  });
}

final List<Product> productList = [
  Product(
    name: 'Product 1',
    imageUrl:
        'https://images.pexels.com/photos/406152/pexels-photo-406152.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    price: 19.99,
    offerPrice: 14.99,
  ),
  Product(
    name: 'Product 2',
    imageUrl:
        'https://images.pexels.com/photos/406152/pexels-photo-406152.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    price: 29.99,
    offerPrice: 24.99,
  ),
  Product(
    name: 'Product 3',
    imageUrl:
        'https://images.pexels.com/photos/406152/pexels-photo-406152.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    price: 19.99,
    offerPrice: 14.99,
  ),
  Product(
    name: 'Product 4',
    imageUrl:
        'https://images.pexels.com/photos/406152/pexels-photo-406152.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    price: 29.99,
    offerPrice: 24.99,
  ),
  Product(
    name: 'Product 5',
    imageUrl:
        'https://images.pexels.com/photos/406152/pexels-photo-406152.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    price: 19.99,
    offerPrice: 14.99,
  ),
  Product(
    name: 'Product 6',
    imageUrl:
        'https://images.pexels.com/photos/406152/pexels-photo-406152.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    price: 29.99,
    offerPrice: 24.99,
  ),
  Product(
    name: 'Product 7',
    imageUrl:
        'https://images.pexels.com/photos/406152/pexels-photo-406152.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    price: 19.99,
    offerPrice: 14.99,
  ),
  Product(
    name: 'Product 8',
    imageUrl:
        'https://images.pexels.com/photos/406152/pexels-photo-406152.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    price: 29.99,
    offerPrice: 2224.9,
  ),
];
