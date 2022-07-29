import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_componentplayground/screens/selection_button/components/BubbleMenuItem.dart';

class BubbleMenu extends StatefulWidget {
  final List<BubbleMenuItem> items;
  const BubbleMenu({Key? key, required this.items}) : super(key: key);

  @override
  State<BubbleMenu> createState() => _BubbleMenuState();
}

class _BubbleMenuState extends State<BubbleMenu>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;

  AlignmentGeometry alignment = Alignment.bottomRight;

  late Animation<double> _animation;

  double _radius = 0;

  late AnimationController _animationController;

  int _itemCount = 0;

  double _initialAngle = 1 * pi;
  double _completeAngle = pi / 2;

  @override
  void initState() {
    _config();
    _animationController = AnimationController(
      vsync: this,
      reverseDuration: const Duration(milliseconds: 500),
      duration: const Duration(milliseconds: 1000),
    )..addListener(() {
        setState(() {});
      });

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.elasticOut));

    super.initState();
  }

  void forwardAnimation() {
    _animationController.forward();
  }

  void _config() {
    _radius = 50;
    _itemCount = widget.items.length;
  }

  @override
  void didUpdateWidget(covariant BubbleMenu oldWidget) {
    _config();
    super.didUpdateWidget(oldWidget);
  }

  void reverseAnimation() {
    _animationController.reverse();
  }

  List<Widget> _buildItems() {
    List<Widget> items = [];
    widget.items.asMap().forEach((index, item) {
      items.add(
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Transform.translate(
              offset: Offset.fromDirection(
                (_initialAngle + ((_completeAngle / (_itemCount - 1)) * index)),
                _animation.value * _radius,
              ),
              child: item,
            ),
          ),
        ),
      );
    });
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ..._buildItems(),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                print("Menu clicked");

                _animationController.status == AnimationStatus.dismissed
                    ? forwardAnimation()
                    : reverseAnimation();
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: Color(0xFF63B4FF),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 0),
                          spreadRadius: 2,
                          blurRadius: 4,
                          color: Colors.black.withOpacity(.25)),
                    ]),
                child: Transform.rotate(
                  angle: lerpDouble(0, -pi / 4, _animation.value)!,
                  child: Icon(
                    _animation.value <= .5
                        ? Icons.qr_code_scanner_rounded
                        : Icons.add_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
