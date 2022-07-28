import 'package:flutter/material.dart';
import 'package:flutter_componentplayground/screens/checkbox/checkbox_screen.dart';
import 'package:flutter_componentplayground/screens/movie/movie_screen.dart';
import 'package:flutter_componentplayground/screens/selection_button/selection_button_screen.dart';

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
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SelectionButtonScreen(),
                ),
              ),
              child: const Text("Selection button"),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MovieScreen(),
                ),
              ),
              child: const Text("Movie"),
            ),
          ],
        ),
      ),
    );
  }
}
