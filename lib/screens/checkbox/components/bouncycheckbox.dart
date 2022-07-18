import 'package:flutter/material.dart';

/*
Checkbox/switcher inspired by https://dribbble.com/shots/5429846-Switcher-XLIV
Made by Blondberg.

*/
class BouncyCheckbox extends StatefulWidget {
  const BouncyCheckbox({Key? key}) : super(key: key);

  @override
  State<BouncyCheckbox> createState() => _BouncyCheckboxState();
}

class _BouncyCheckboxState extends State<BouncyCheckbox>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controller2;

  late Animation<Alignment> alignment;

  late Animation<double> width;
  late Animation<double> borderWidth;
  late Animation<double> scale;

  late Animation<Color?> color;
  late Animation<Color?> bgColor;

  late Animation<double> elasticScale;
  late Animation<double> elasticScale2;

  bool isSelected = false;

  @override
  void dispose() {
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addStatusListener((status) {});

    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed ||
            status == AnimationStatus.dismissed) controller2.reset();
      });

    alignment = Tween<Alignment>(
            begin: Alignment.centerLeft, end: Alignment.centerRight)
        .animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 1, curve: Curves.easeInOut),
      ),
    );
    borderWidth = Tween<double>(begin: 10, end: 5).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 1, curve: Curves.linear),
      ),
    );
    width = Tween<double>(begin: 30, end: 10).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 1, curve: Curves.linear),
      ),
    );

    scale = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 1.0,
          end: 0.9,
        ),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 0.9,
          end: 1.0,
        ),
        weight: 50,
      )
    ]).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 1),
      ),
    );

    elasticScale = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: 1.0,
            end: 1.3,
          ),
          weight: 50,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: 1.3,
            end: 1.0,
          ),
          weight: 50,
        )
      ],
    ).animate(
      CurvedAnimation(
        parent: controller2,
        curve: const Interval(.2, 1, curve: Curves.bounceOut),
      ),
    );

    elasticScale2 = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: 1.0,
            end: .9,
          ),
          weight: 50,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: .9,
            end: 1.0,
          ),
          weight: 50,
        )
      ],
    ).animate(
      CurvedAnimation(
        parent: controller2,
        curve: const Interval(.2, 1, curve: Curves.bounceOut),
      ),
    );

    color = ColorTween(begin: Colors.transparent, end: Colors.white).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, .3, curve: Curves.linear),
      ),
    );
    bgColor = ColorTween(begin: Colors.red.shade300, end: Colors.green.shade300)
        .animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, .3, curve: Curves.linear),
      ),
    );
    super.initState();
  }

  void onCheck() {
    if (!controller.isAnimating && !controller2.isAnimating) {
      setState(() {
        isSelected = !isSelected;
        print(isSelected);
        controller2.forward().orCancel;
        if (isSelected) {
          controller.forward().orCancel;
        } else {
          controller.reverse().orCancel;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 3,
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Center(
          child: GestureDetector(
            onTap: onCheck,
            child: AnimatedBuilder(
              animation: Listenable.merge([controller, controller2]),
              builder: (BuildContext context, Widget? child) {
                return Transform.scale(
                  scale: scale.value,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    height: 40,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: bgColor.value,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 5),
                            color: bgColor.value!.withOpacity(.40),
                            blurRadius: 5,
                            spreadRadius: 2),
                      ],
                    ),
                    child: Align(
                      alignment: alignment.value,
                      child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 30,
                        child: Transform(
                          transform: Matrix4.diagonal3Values(
                              elasticScale.value, elasticScale2.value, 1.0),
                          alignment: Alignment.center,
                          child: Container(
                            height: 30,
                            width: width.value,
                            decoration: BoxDecoration(
                              color: color.value,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  width: borderWidth.value,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
