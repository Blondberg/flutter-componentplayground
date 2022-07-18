import 'package:flutter/material.dart';
import 'package:flutter_componentplayground/screens/checkbox/checkbox_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CheckboxScreen(),
                ),
              ),
              child: const Text("Checkbox"),
            ),
          ],
        ),
      ),
    );
  }
}
