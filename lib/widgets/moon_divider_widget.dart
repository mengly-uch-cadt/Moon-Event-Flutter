import 'package:flutter/material.dart';

class MoonDividerWidget extends StatelessWidget {
  const MoonDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey[300],
      height: 0.5,
    );
  }
}
