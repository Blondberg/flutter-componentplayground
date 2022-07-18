import 'package:flutter/material.dart';
import 'package:flutter_componentplayground/screens/checkbox/components/bouncycheckbox.dart';

class CheckboxScreen extends StatelessWidget {
  const CheckboxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          BouncyCheckbox(),
        ],
      ),
    );
  }
}
