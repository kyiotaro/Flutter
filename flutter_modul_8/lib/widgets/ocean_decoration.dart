import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Widget dekoratif gelembung laut dengan animasi
class OceanBubbles extends StatelessWidget {
  final int count;
  final Color color;
  final Alignment alignment;

  const OceanBubbles({
    super.key,
    this.count = 5,
    this.color = Colors.white,
    this.alignment = Alignment.bottomLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(count, (index) {
        final size = 8.0 + (index * 3.0);
        final left = (index * 30.0) % MediaQuery.of(context).size.width;
        final top = (index * 80.0) % (MediaQuery.of(context).size.height * 0.5);

        return Positioned(
          left: left,
          top: top,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withAlpha(((0.1 + (index * 0.05)) * 255).round()),
              border: Border.all(
                color: color.withAlpha((0.3 * 255).round()),
                width: 0.5,
              ),
            ),
          ),
        );
      }),
    );
  }
}

/// Widget dekoratif ombak di bagian bawah
class OceanWaves extends StatelessWidget {
  final Color color;
  final double height;
  final double opacity;

  const OceanWaves({
    super.key,
    this.color = Colors.white,
    this.height = 80,
    this.opacity = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WavePainter(color: color.withAlpha((opacity * 255).round())),
      size: Size(MediaQuery.of(context).size.width, height),
    );
  }
}

class WavePainter extends CustomPainter {
  final Color color;

  WavePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // Gelombang 1 - Besar dan dinamis (kombinasi multiple waves)
    final paint1 = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path1 = Path();
    path1.moveTo(0, size.height * 0.45);

    for (double x = 0; x <= size.width + 20; x += 15) {
      final wave1 = math.sin(x / 35) * size.height * 0.12;
      final wave2 = math.sin(x / 70) * size.height * 0.08;
      final wave3 = math.cos(x / 50) * size.height * 0.05;
      final y = size.height * 0.45 + wave1 + wave2 + wave3;
      path1.lineTo(x, y);
    }

    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();
    canvas.drawPath(path1, paint1);

    // Gelombang 2 - Medium dengan fase berbeda
    final paint2 = Paint()
      ..color = color.withAlpha((0.65 * 255).round())
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(0, size.height * 0.58);

    for (double x = 0; x <= size.width + 20; x += 15) {
      final wave1 = math.sin((x + 50) / 45) * size.height * 0.09;
      final wave2 = math.cos((x + 25) / 80) * size.height * 0.06;
      final y = size.height * 0.58 + wave1 + wave2;
      path2.lineTo(x, y);
    }

    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);

    // Gelombang 3 - Kecil dan lembut di depan
    final paint3 = Paint()
      ..color = color.withAlpha((0.4 * 255).round())
      ..style = PaintingStyle.fill;

    final path3 = Path();
    path3.moveTo(0, size.height * 0.68);

    for (double x = 0; x <= size.width + 20; x += 15) {
      final wave1 = math.sin((x + 100) / 55) * size.height * 0.07;
      final wave2 = math.sin((x + 50) / 90) * size.height * 0.04;
      final y = size.height * 0.68 + wave1 + wave2;
      path3.lineTo(x, y);
    }

    path3.lineTo(size.width, size.height);
    path3.lineTo(0, size.height);
    path3.close();
    canvas.drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => false;
}

/// Widget dekoratif ikan/hewan laut dengan icon
class OceanCreatures extends StatelessWidget {
  const OceanCreatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Ikan di kiri atas
        Positioned(
          left: 20,
          top: 100,
          child: Opacity(
            opacity: 0.15,
            child: Icon(
              Icons.bubble_chart,
              size: 60,
              color: Colors.white,
            ),
          ),
        ),
        // Bintang laut di kanan atas
        Positioned(
          right: 15,
          top: 80,
          child: Opacity(
            opacity: 0.12,
            child: Icon(
              Icons.star_outline,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
        // Kerang/Shell di kiri bawah
        Positioned(
          left: 30,
          bottom: 150,
          child: Opacity(
            opacity: 0.1,
            child: Icon(
              Icons.circle_outlined,
              size: 45,
              color: Colors.white,
            ),
          ),
        ),
        // Gelembung/Ikan di kanan bawah
        Positioned(
          right: 25,
          bottom: 200,
          child: Opacity(
            opacity: 0.13,
            child: Icon(
              Icons.water_drop_outlined,
              size: 55,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

/// Widget dekorasi lengkap dengan ombak, gelembung, dan makhluk laut
class OceanBackgroundDecoration extends StatelessWidget {
  final bool showWaves;
  final bool showBubbles;
  final bool showCreatures;
  final Color color;

  const OceanBackgroundDecoration({
    super.key,
    this.showWaves = true,
    this.showBubbles = true,
    this.showCreatures = true,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (showCreatures) OceanCreatures(),
        if (showBubbles) OceanBubbles(color: color),
        if (showWaves)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: OceanWaves(color: color),
          ),
      ],
    );
  }
}

/// Widget untuk corner dekorasi (sudut halaman)
class CornerOceanDecor extends StatelessWidget {
  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;
  final Color color;

  const CornerOceanDecor({
    super.key,
    this.topLeft = false,
    this.topRight = false,
    this.bottomLeft = false,
    this.bottomRight = false,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (topLeft)
          Positioned(
            top: -20,
            left: -20,
            child: Opacity(
              opacity: 0.1,
              child: Icon(
                Icons.bubble_chart,
                size: 120,
                color: color,
              ),
            ),
          ),
        if (topRight)
          Positioned(
            top: -20,
            right: -20,
            child: Opacity(
              opacity: 0.1,
              child: Icon(
                Icons.bubble_chart,
                size: 120,
                color: color,
              ),
            ),
          ),
        if (bottomLeft)
          Positioned(
            bottom: -20,
            left: -20,
            child: Opacity(
              opacity: 0.1,
              child: Icon(
                Icons.bubble_chart,
                size: 120,
                color: color,
              ),
            ),
          ),
        if (bottomRight)
          Positioned(
            bottom: -20,
            right: -20,
            child: Opacity(
              opacity: 0.1,
              child: Icon(
                Icons.bubble_chart,
                size: 120,
                color: color,
              ),
            ),
          ),
      ],
    );
  }
}
