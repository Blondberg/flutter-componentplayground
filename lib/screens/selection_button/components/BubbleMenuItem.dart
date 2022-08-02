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
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kDefaultBackground,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 0),
                    spreadRadius: 2,
                    blurRadius: 2,
                    color: Colors.black.withOpacity(.30)),
              ]),
          child: widget.icon,
        ),
      ),
    );
  }
}
