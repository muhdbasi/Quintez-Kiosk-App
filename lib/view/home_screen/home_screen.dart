import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quintez_kiosk_app/controller/menu_provider.dart';
import 'package:quintez_kiosk_app/view/checkout_screen/checkout_screen.dart';
import 'package:quintez_kiosk_app/view/home_screen/widgets/bottom.dart';
import 'package:collection/collection.dart';
import 'package:quintez_kiosk_app/view/home_screen/widgets/product_card_widget.dart';

import 'widgets/menu_options.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<String> selectedOptionNotifier = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    final menuProvider = Provider.of<MenuProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      menuProvider.getMenus().then((_) {
        // After fetching the menus, set the default selected option
        setState(() {
          if (menuProvider.menusList.isNotEmpty) {
            var firstMenu = menuProvider.menusList[0];
            if (firstMenu.menus.isNotEmpty) {
              selectedOptionNotifier.value = firstMenu.menus[0].menu.menuName;
            }
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    log("Rebuilded------->>>>>>>>>>");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: Stack(
        children: [
          Positioned.fill(
            child: Row(
              children: [
                Flexible(
                  flex: 5,
                  child: Container(
                    color: Colors.white70,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 12,
                    ),
                    child: Consumer<MenuProvider>(
                      builder: (context, value, child) => MenuOptions(
                        selectedOption: selectedOptionNotifier,
                        // onMenuOptionSelected: onMenuOptionSelected,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 15,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.9,
                            width: size.width,
                            child: Consumer<MenuProvider>(
                              builder: (context, value, child) {
                                // Find the selected menu option
                                var selectedMenu = value.menusList.isNotEmpty
                                    ? value.menusList[0].menus.firstWhereOrNull(
                                        (menu) =>
                                            menu.menu.menuName ==
                                            selectedOptionNotifier.value)
                                    : null;

                                // Check if selectedMenu is null, and handle accordingly
                                if (selectedMenu == null) {
                                  // Handle the case when the selected menu option is not found
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Lottie.asset(
                                          'lib/asset/lottie/food.json'),
                                      const Text(
                                        'Dishes are currently not available for this menu',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.5,
                                        ),
                                      )
                                    ],
                                  );
                                }

                                // Get the products of the selected menu option
                                var products = selectedMenu.products;

                                return products!.isEmpty
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Lottie.asset(
                                              'lib/asset/lottie/food.json'),
                                          const Text(
                                            'Dishes are currently not available for this menu',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.5,
                                            ),
                                          )
                                        ],
                                      )
                                    : GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                        ),
                                        itemCount: products.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: ProductCard(
                                                product: products[
                                                    index], // Pass the ProductElement object
                                                index: index,
                                                size: size,
                                              ),
                                            ),
                                          );
                                        },
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
        height: size.height * 0.085,
        color: Colors.green,
        child: CustomButton(
          height: size.height * 0.06,
          width: size.width * 0.3,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CheckOutScreen(),
              ),
            );
          },
          text: "Go to cart",
        ),
      ),
    );
  }
}
