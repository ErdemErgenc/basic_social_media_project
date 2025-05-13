import 'package:flutter/material.dart';

class MyPostButton extends StatelessWidget {
  final void Function()? onTap;

  const MyPostButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),

          child: Center(
            child: Icon(
              Icons.done,
              color: Theme.of(context).colorScheme.inversePrimary,
              size: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}
