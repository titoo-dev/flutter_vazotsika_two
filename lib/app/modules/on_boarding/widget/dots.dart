import 'package:flutter/material.dart';

class Dots extends StatelessWidget {
  final bool isActive;

  const Dots({Key? key, this.isActive = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 8 : 6,
      width: isActive ? 8 : 6,
      decoration: BoxDecoration(
          color: isActive
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12)),
    );
  }
}
