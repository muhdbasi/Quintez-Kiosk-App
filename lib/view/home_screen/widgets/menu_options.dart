import 'package:flutter/material.dart';

class MenuOptions extends StatefulWidget {
  const MenuOptions({Key? key}) : super(key: key);

  @override
  _MenuOptionsState createState() => _MenuOptionsState();
}

class _MenuOptionsState extends State<MenuOptions> {
  String selectedOption = 'Breakfast'; // Default selected menu option

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: const Icon(
            Icons.local_dining_outlined,
            size: 36,
            color: Colors.black,
          ),
        ),
        buildOptionButton('Breakfast'),
        buildOptionButton('Lunch'),
        buildOptionButton('Dinner'),
        buildOptionButton('Snacks'),
        buildOptionButton('Beverages'),
      ],
    );
  }

  Widget buildOptionButton(String title) {
    Size size = MediaQuery.of(context).size;
    bool isSelected = selectedOption == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey,
            width: 2,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: size.height * 0.017,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.green,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
