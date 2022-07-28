import 'package:flutter/material.dart';

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
      height: 60,
      width: 60,
      alignment: Alignment.center,
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          height: 30,
          width: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
          child: widget.icon,
        ),
      ),
    );
  }
}
