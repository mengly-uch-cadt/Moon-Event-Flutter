import 'package:flutter/material.dart';

class MoonProfileInfoWidget extends StatelessWidget {
  const MoonProfileInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context)
            .appBarTheme
            .backgroundColor, // Use the backgroundColor from the appBarTheme in primaryTheme
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Close the keyboard
        },
        // child: ,
      )
    );
  }
}