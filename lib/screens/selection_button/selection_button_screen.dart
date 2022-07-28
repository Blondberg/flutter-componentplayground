import 'package:flutter/material.dart';
import 'package:flutter_componentplayground/screens/selection_button/components/BubbleMenu.dart';
import 'package:flutter_componentplayground/screens/selection_button/components/BubbleMenuItem.dart';

class SelectionButtonScreen extends StatelessWidget {
  const SelectionButtonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Stack(
          children: [
            BubbleMenu(
              items: [
                BubbleMenuItem(
                  icon: Icon(Icons.add),
                  onTap: () => print("tap"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
