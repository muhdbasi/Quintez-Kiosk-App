import 'package:flutter/material.dart';
import 'package:quintez_kiosk_app/view/home_screen/home_screen.dart';

class ProductGridview extends StatefulWidget {
  final Product product;

  const ProductGridview({super.key, required this.product});

  @override
  ProductGridviewState createState() => ProductGridviewState();
}

class ProductGridviewState extends State<ProductGridview> {
  int productCount = 1;
  bool isSelected = false;

  void incrementProductCount() {
    setState(() {
      productCount++;
    });
  }

  void decrementProductCount() {
    setState(() {
      if (productCount > 1) {
        productCount--;
      }
    });
  }

  double getTotalPrice() {
    return widget.product.offerPrice * productCount;
  }

  void toggleSelection() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Image.network(widget.product.imageUrl),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.product.name,
              style: TextStyle(
                fontSize: size.height * 0.02,
                color: Colors.black,
              ),
            ),
            Theme(
              data: ThemeData(
                checkboxTheme: CheckboxThemeData(
                  fillColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return null;
                      }
                      if (states.contains(MaterialState.selected)) {
                        return Colors.green;
                      }
                      return null;
                    },
                  ),
                ),
              ),
              child: Checkbox(
                value: isSelected,
                onChanged: (value) => toggleSelection(),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Price: \$${widget.product.price.toStringAsFixed(2)} ',
              style: TextStyle(
                fontSize: size.height * 0.02,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            Text(
              " \$${widget.product.offerPrice.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: size.height * 0.02,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Row(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              iconSize: size.height * 0.02,
              onPressed: decrementProductCount,
            ),
            Text(
              productCount.toString(),
              style: TextStyle(fontSize: size.height * 0.02),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              iconSize: size.height * 0.02,
              onPressed: incrementProductCount,
            ),
            Text(
              'Total: \$${getTotalPrice().toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: size.height * 0.02,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
