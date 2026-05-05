import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';


class BreathingGradientFab extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;

  const BreathingGradientFab({
    super.key,
    required this.onTap,
    required this.child,
  });

  @override
  State<BreathingGradientFab> createState() => _BreathingGradientFabState();
}

class _BreathingGradientFabState extends State<BreathingGradientFab>
    with TickerProviderStateMixin {
  late AnimationController _breathController;
  late AnimationController _gradientController;
  late Animation<double> _breath;

  @override
  void initState() {
    super.initState();

    // ================= 🫁 BREATHING SPEED =================
    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800), // 🫁 slower = premium
    )..repeat(reverse: true);

    _breath = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _breathController,
        curve: Curves.easeInOutSine,
      ),
    );

    // ================= 🌈 GRADIENT FLOW SPEED =================
    _gradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5), // 🌈 VERY SMOOTH
    )..repeat();
  }

  @override
  void dispose() {
    _breathController.dispose();
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _breathController,
          _gradientController,
        ]),
        builder: (context, _) {
          // 🌊 sine-based movement (key smoothness trick)
          final double wave = sin(_gradientController.value * 2 * pi);
          return Transform.scale(
            scale: _breath.value,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment(-1.2 + wave * 0.6, -1),
                  end: Alignment(1.2 + wave * 0.6, 1),
                  colors: const [
                    Color.fromARGB(255, 253, 231, 142),
                    yellow,
                    Color(0xFFFF6F00),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.4),
                    blurRadius: 9,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Center(child: widget.child),
            ),
          );
        },
      ),
    );
  }
}
