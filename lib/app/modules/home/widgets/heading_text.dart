import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  const HeadingText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      child: Text(
        "Discover",
        style: Theme.of(context)
            .textTheme
            .headline4
            ?.copyWith(fontWeight: FontWeight.w500, color: Colors.black87),
      ),
    );
  }
}
