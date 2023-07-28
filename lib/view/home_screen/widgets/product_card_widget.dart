import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quintez_kiosk_app/hive_model/cart_model.dart';
import 'package:quintez_kiosk_app/model/menus_model.dart' as menumodel;
import '../../../controller/menu_provider.dart';

class ProductCard extends StatelessWidget {
  final Size size;
  final menumodel.ProductElement product;
  final int index;

  const ProductCard({
    required this.product,
    required this.index,
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implement your product card UI here using the `product` object
    return FittedBox(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: size.width * 0.35,
              height: size.height * 0.14,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  product.product.images[0].imageUrl,
                  fit: BoxFit.cover,
                ),
              )),
          SizedBox(
            height: size.height * 0.007,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.product.name.toString(),
                style: TextStyle(
                  fontSize: size.height * 0.02,
                  color: Colors.black,
                ),
              ),
              // Consumer<MenuProvider>(
              //   builder: (context, value, child) => IconButton(
              //       onPressed: value.isProductInCart(product.product.productId)
              //           ? () {
              //               log("Already in cart");
              //             }
              //           : () {
              //               final item = CartItem(
              //                   description: product.product.description,
              //                   imageUrl: product.product.images[0].imageUrl,
              //                   productId: product.product.productId,
              //                   productName: product.product.name,
              //                   price: product.pricings[0].price,
              //                   quantity: 1);
              //               value.addToCart(item);
              //             },
              //       icon: Icon(
              //         value.isProductInCart(product.product.productId)
              //             ? Icons.shopping_cart
              //             : Icons.shopping_cart_outlined,
              //         size: size.height * 0.025,
              //       )),
              // )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Price :',
                style: TextStyle(
                  fontSize: size.height * 0.017,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: size.height * 0.005,
              ),
              Text(
                ' \$2.00',
                style: TextStyle(
                  fontSize: size.height * 0.017,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              SizedBox(
                width: size.height * 0.005,
              ),
              Text(
                "\$${product.pricings[0].price.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: size.height * 0.02,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Consumer<MenuProvider>(
            builder: (context, value, child) => TextButton.icon(
              icon: Icon(
                value.isProductInCart(product.product.productId)
                    ? Icons.shopping_cart
                    : Icons.shopping_cart_outlined,
                size: size.height * 0.023,
              ),
              onPressed: value.isProductInCart(product.product.productId)
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(15.0),
                          elevation: 6.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          content: Text(
                            'Already in cart',
                            style: TextStyle(fontSize: size.height * 0.025),
                          ),
                        ),
                      );
                    }
                  : () {
                      final item = CartItem(
                          description: product.product.description,
                          imageUrl: product.product.images[0].imageUrl,
                          productId: product.product.productId,
                          productName: product.product.name,
                          price: product.pricings[0].price,
                          quantity: 1);
                      value.addToCart(item);
                    },
              label: Text(
                'Add',
                style: TextStyle(
                  fontSize: size.height * 0.02,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
