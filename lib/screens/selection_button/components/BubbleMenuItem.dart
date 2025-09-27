import 'package:flutter/material.dart';
import 'package:flutter_componentplayground/constants.dart';

class BubbleMenuItem extends StatefulWidget {
  final onTap;
  final Icon icon;
  const BubbleMenuItem({Key? key, required this.onTap, required this.icon})
      : super(key: key);

  @override
  State<BubbleMenuItem> createState() => _BubbleMenuItemState();
}

class _BubbleMenuItemState extends State<BubbleMenuItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 50,
      width: 50,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white,
              ),
              BoxShadow(
                color: kDefaultBackground,
                spreadRadius: -2.0,
              ),
            ],
          ),
          child: widget.icon,
        ),
      ),
    );
  }
}
