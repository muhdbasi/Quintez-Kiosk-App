import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quintez_kiosk_app/controller/menu_provider.dart';

class MenuOptions extends StatefulWidget {
  // final void Function(String) onMenuOptionSelected;
  final ValueNotifier<String> selectedOption;

  const MenuOptions({
    Key? key,
    required this.selectedOption,
  }) : super(key: key);

  @override
  MenuOptionsState createState() => MenuOptionsState();
}

class MenuOptionsState extends State<MenuOptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 18,
        ),
        Image.network(
          'https://logodownload.org/wp-content/uploads/2017/10/starbucks-logo-1.png',
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Consumer<MenuProvider>(
            builder: (context, value, child) {
              if (value.menusList.isEmpty || value.menusList[0].menus.isEmpty) {
                return Center(
                  child: Lottie.asset('assets\\animation_lkkrmzj5.json'),
                );
              } else {
                return ListView.builder(
                  itemCount: value.menusList[0].menus.length,
                  itemBuilder: (context, index) {
                    final option =
                        value.menusList[0].menus[index].menu.menuName;
                    return buildOptionButton(option);
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget buildOptionButton(String title) {
    Size size = MediaQuery.of(context).size;
    bool isSelected = widget.selectedOption.value == title;

    return Consumer<MenuProvider>(
      builder: (context, value, child) => GestureDetector(
        onTap: () {
          // Notify the parent widget about the selected menu option.
          // widget.onMenuOptionSelected(title);
          value.onMenuOptionSelected(title, widget.selectedOption);
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
      ),
    );
  }
}
