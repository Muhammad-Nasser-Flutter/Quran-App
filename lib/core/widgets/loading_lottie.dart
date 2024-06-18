import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../theming/assets.dart';

class LoadingLottie extends StatefulWidget {
  const LoadingLottie({super.key});

  @override
  State<LoadingLottie> createState() => _LoadingLottieState();
}

class _LoadingLottieState extends State<LoadingLottie>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        Assets.loadingLottie,
        controller: _controller,
        onLoaded: (composition) {
          _controller
            ..duration = composition.duration
            ..forward()
            ..repeat(
              period: const Duration(milliseconds: 1300),
            );
        },
      ),
    );
  }
}
