import 'package:flutter/material.dart';

class MenuOptions extends StatefulWidget {
  const MenuOptions({Key? key}) : super(key: key);

  @override
  MenuOptionsState createState() => MenuOptionsState();
}

class MenuOptionsState extends State<MenuOptions> {
  String selectedOption = 'Breakfast';
  final List<String> menuOptions = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks',
    'Beverages'
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: menuOptions.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: const Icon(
              Icons.local_dining_outlined,
              size: 36,
              color: Colors.black,
            ),
          );
        } else {
          final option = menuOptions[index - 1];
          return buildOptionButton(option);
        }
      },
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
