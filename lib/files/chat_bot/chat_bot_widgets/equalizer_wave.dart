import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EqualizerWave extends StatefulWidget {
  const EqualizerWave({
    super.key,
    required this.levelListenable,
  });

  final ValueListenable<double> levelListenable;

  @override
  State<EqualizerWave> createState() => _EqualizerWaveState();
}

class _EqualizerWaveState extends State<EqualizerWave>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  static const int _barCount = 25;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([controller, widget.levelListenable]),
      builder: (_, __) {
        return CustomPaint(
          painter: _ReactiveWavePainter(
            progress: controller.value,
            barCount: _barCount,
            level: widget.levelListenable.value,
          ),
          size: const Size(double.infinity, 40),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _ReactiveWavePainter extends CustomPainter {
  const _ReactiveWavePainter({
    required this.progress,
    required this.barCount,
    required this.level,
  });

  final double progress;
  final int barCount;
  final double level;

  @override
  void paint(Canvas canvas, Size size) {
    const gradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Color(0xFFFFA000),
        Color(0xFF000000),
      ],
    );

    final shader = gradient.createShader(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );

    final paint = Paint()
      ..shader = shader
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / (barCount * 2.2);

    final phase = progress * 2 * pi;
    final normalizedLevel = level.clamp(0.0, 1.0).toDouble();
    final minHeight = size.height * 0.10;
    final usableHeight = size.height - minHeight;
    final barWidth = size.width / barCount;

    for (int i = 0; i < barCount; i++) {
      final x = (i * barWidth) + (barWidth / 2);
      final position = barCount == 1 ? 0.0 : i / (barCount - 1);
      final distanceFromCenter = (position - 0.5).abs() * 2;
      final envelope = 0.35 + ((1 - distanceFromCenter) * 0.65);
      final ripple =
          (sin((position * 2.4 * pi) + (phase * 2.2)) + 1) / 2;
      final shimmer =
          (sin((position * 5.2 * pi) - (phase * 3.4)) + 1) / 2;
      final pulse = (ripple * 0.6) + (shimmer * 0.4);
      final intensity = (
          ((0.08 + (normalizedLevel * 0.92)) * 0.55) +
              (normalizedLevel * pulse * 0.45)
      ).clamp(0.0, 1.0).toDouble();
      final barHeight =
          minHeight +
              (usableHeight *
                  (envelope * intensity).clamp(0.0, 1.0).toDouble());

      canvas.drawLine(
        Offset(x, size.height),
        Offset(x, size.height - barHeight),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ReactiveWavePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.barCount != barCount ||
        oldDelegate.level != level;
  }
}
