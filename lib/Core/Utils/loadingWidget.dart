import 'dart:async';

import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  Color? color;
  LoadingWidget({
    this.color,
    Key? key,
  }) : super(key: key);
  final List<Color> colors = [
    const Color(0XFF854D9C),
    const Color(0XFFED519A),
    const Color(0XFF8188CE),
    const Color(0XFFFFF200),
    const Color(0XFFED1C24),
    const Color(0XFF6ABD45),
    const Color(0XFF231F20),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color ?? Colors.white,
      body: Center(
          child: ColorLoader(
        colors: colors,
        duration: const Duration(milliseconds: 1200),
      )),
    );
  }
}

class ColorLoader extends StatefulWidget {
  final List<Color> colors;
  final Duration duration;

  // ignore: use_key_in_widget_constructors
  const ColorLoader({required this.colors, required this.duration});

  @override
  _ColorLoaderState createState() =>
      _ColorLoaderState(this.colors, this.duration);
}

class _ColorLoaderState extends State<ColorLoader>
    with SingleTickerProviderStateMixin {
  late final List<Color> colors;
  late final Duration duration;
  late Timer timer;

  _ColorLoaderState(this.colors, this.duration);

  //noSuchMethod(Invocation i) => super.noSuchMethod(i);

  List<ColorTween> tweenAnimations = [];
  int tweenIndex = 0;

  late AnimationController controller;
  List<Animation<Color?>> colorAnimations = [];

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: duration,
    );

    for (int i = 0; i < colors.length - 1; i++) {
      tweenAnimations.add(ColorTween(begin: colors[i], end: colors[i + 1]));
    }

    tweenAnimations
        .add(ColorTween(begin: colors[colors.length - 1], end: colors[0]));

    for (int i = 0; i < colors.length; i++) {
      Animation<Color?> animation = tweenAnimations[i].animate(CurvedAnimation(
          parent: controller,
          curve: Interval((1 / colors.length) * (i + 1) - 0.05,
              (1 / colors.length) * (i + 1),
              curve: Curves.linear)));

      colorAnimations.add(animation);
    }

    tweenIndex = 0;

    timer = Timer.periodic(duration, (Timer t) {
      setState(() {
        tweenIndex = (tweenIndex + 1) % colors.length;
      });
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 5.0,
        valueColor: colorAnimations[tweenIndex],
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }
}
