import 'dart:async';

import 'package:flutter/material.dart';

class CustomLoading extends StatefulWidget {
  const CustomLoading({super.key});

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading> {
  late Timer timer;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    startLoading();
  }

  startLoading() async {
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        if (currentIndex == 2) {
          currentIndex = 0;
        } else {
          currentIndex += 1;
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: AnimatedScale(
            curve: Curves.ease,
            duration: const Duration(milliseconds: 500),
            scale: currentIndex == index ? 1.5 : 1,
            child: Container(
              height: 20,
              width: 5,
              color: currentIndex == index ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
