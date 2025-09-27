import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_componentplayground/constants.dart';
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

  AlignmentGeometry alignment = Alignment.bottomCenter;

  late Animation<double> _animation;
  late Animation<double> _backgroundAnimation;

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
      duration: const Duration(milliseconds: 900),
    )..addListener(() {
        setState(() {});
      });

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.elasticOut));

    _backgroundAnimation = Tween<double>(begin: 0.0, end: .8).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
      ),
    );

    super.initState();
  }

  void forwardAnimation() {
    _animationController.forward();
  }

  void _config() {
    _radius = 60;
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
            alignment: Alignment.bottomCenter,
            child: Transform.scale(
              scale: 1, //_animation.value,
              child: Transform.translate(
                offset: Offset.fromDirection(
                  -pi / 2, _animation.value * _radius * (index + 1),
                  // (_initialAngle +
                  //     ((_completeAngle / (_itemCount - 1)) * index)),
                  // 1 * _radius,
                ),
                child: item,
              ),
            ),
          ),
        ),
      );
    });
    return items;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        IgnorePointer(
          ignoring: _animationController.value > 0 ? false : true,
          child: GestureDetector(
            onTap: _animationController.status == AnimationStatus.completed
                ? () => reverseAnimation()
                : () {},
            child: Positioned.fill(
              child: Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                    color: kDefaultBackground
                        .withOpacity(_backgroundAnimation.value)),
              ),
            ),
          ),
        ),
        ..._buildItems(),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                print("Menu clicked");

                _animationController.status == AnimationStatus.dismissed
                    ? forwardAnimation()
                    : reverseAnimation();
              },
              child: Transform.scale(
                scale: 1, //-_animation.value * 0.3 + 1,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Color.lerp(
                          kPrimaryYellow, Colors.white, _animation.value),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            spreadRadius: 2,
                            blurRadius: 2,
                            color: Colors.black.withOpacity(.30)),
                      ]),
                  child: Transform.rotate(
                    angle: lerpDouble(0, -pi / 4, _animation.value)!,
                    child: Icon(
                      _animation.value <= .5
                          ? Icons.qr_code_scanner_rounded
                          : Icons.add_rounded,
                      color: Color.lerp(
                          Colors.white, kPrimaryYellow, _animation.value),
                      size: 30,
                    ),
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
