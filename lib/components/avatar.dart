import 'package:flutter/material.dart';

class SpinningAvatar extends StatefulWidget {
  const SpinningAvatar({super.key});

  @override
  State<SpinningAvatar> createState() => _SpinningAvatarState();
}

class _SpinningAvatarState extends State<SpinningAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(); // sürekli döner
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: 4,
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 70,
          backgroundImage: AssetImage("lib/images/resim.jpg"),
        ),
      ),
    );
  }
}
