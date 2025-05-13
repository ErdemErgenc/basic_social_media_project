import 'package:flutter/material.dart';

class MyBackbutton extends StatelessWidget {
  const MyBackbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.inversePrimary,
          size: 24.0,
        ),
      ),
    );
  }
}
