import 'package:flutter/material.dart';

class MyAppBarItem extends StatelessWidget {
  final Icon icon;
  final onTap;
  final Color? color;
  const MyAppBarItem({
    Key? key,
    required this.icon,
    this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: color == null
                ? Colors.white.withOpacity(.29)
                : color!.withOpacity(.29),
          ),
        ),
        child: icon,
      ),
    );
  }
}
