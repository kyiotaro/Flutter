import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Controller untuk gelombang horizontal (terus berulang)
  late AnimationController _waveController;

  // Controller untuk posisi naik awal
  late AnimationController _positionController;

  // Controller untuk animasi naik turun (floating) setelah sampai atas
  late AnimationController _floatController;

  // Controller untuk teks & tombol muncul
  late AnimationController _contentController;

  // Animasi posisi gelombang naik awal
  late Animation<double> _positionAnimation1;
  late Animation<double> _positionAnimation2;
  late Animation<double> _positionAnimation3;
  late Animation<double> _positionAnimation4;

  // Animasi untuk teks & tombol
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  // Status untuk mengontrol switch animasi
  bool _isFloating = false;

  // Posisi akhir setiap gelombang
  final double _endPosition1 = 0.1;
  final double _endPosition2 = 0.15;
  final double _endPosition3 = 0.2;
  final double _endPosition4 = 0.25;

  @override
  void initState() {
    super.initState();

    // Controller gelombang horizontal
    _waveController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    // Controller posisi naik awal
    _positionController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    // Controller naik turun (floating) - lebih lambat dan smooth
    _floatController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    // Controller teks & tombol
    _contentController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Animasi posisi naik awal
    _positionAnimation1 = Tween<double>(begin: 1.0, end: _endPosition1).animate(
      CurvedAnimation(parent: _positionController, curve: Curves.easeOut),
    );

    _positionAnimation2 = Tween<double>(begin: 1.0, end: _endPosition2).animate(
      CurvedAnimation(parent: _positionController, curve: Curves.easeOut),
    );

    _positionAnimation3 = Tween<double>(begin: 1.0, end: _endPosition3).animate(
      CurvedAnimation(parent: _positionController, curve: Curves.easeOut),
    );

    _positionAnimation4 = Tween<double>(begin: 1.0, end: _endPosition4).animate(
      CurvedAnimation(parent: _positionController, curve: Curves.easeOut),
    );

    // Animasi teks & tombol
    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOutCubic),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeIn),
    );

    // Listener untuk switch ke animasi floating
    _positionController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isFloating = true;
        });
        _floatController.repeat(reverse: true); // Naik turun terus menerus
      }
    });

    _startAnimations();
  }

  void _startAnimations() async {
    _positionController.forward();

    // Tunggu sampai gelombang hampir selesai naik
    await Future.delayed(const Duration(milliseconds: 2500));
    _contentController.forward();
  }

  @override
  void dispose() {
    _waveController.dispose();
    _positionController.dispose();
    _floatController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  // Fungsi untuk menghitung posisi Y dengan mempertimbangkan floating
  double _getCurrentPosition(double basePosition, double floatOffset) {
    if (!_isFloating) {
      return basePosition;
    }
    // Saat floating: posisi akhir + offset naik turun
    // Gunakan sin untuk gerakan smooth naik turun
    final double floatValue =
        math.sin(_floatController.value * math.pi * 2) * floatOffset;
    return basePosition + floatValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background putih
          Container(color: Colors.white),

          // Gelombang 1 - #052952 (paling belakang)
          AnimatedBuilder(
            animation: Listenable.merge([
              _positionAnimation1,
              _waveController,
              if (_isFloating) _floatController else _positionController,
            ]),
            builder: (context, child) {
              final double currentPos = _getCurrentPosition(
                _positionAnimation1.value,
                0.03,
              );
              return CustomPaint(
                painter: Painter(
                  animationValue: currentPos,
                  waveAnimation: _waveController.value,
                  color: const Color(0xFF052952),
                  waveHeight: 25,
                  frequency: 1.0,
                  phase: 0,
                ),
                child: Container(),
              );
            },
          ),

          // Gelombang 2 - #053970
          AnimatedBuilder(
            animation: Listenable.merge([
              _positionAnimation2,
              _waveController,
              if (_isFloating) _floatController else _positionController,
            ]),
            builder: (context, child) {
              final double currentPos = _getCurrentPosition(
                _positionAnimation2.value,
                0.025,
              );
              return CustomPaint(
                painter: Painter(
                  animationValue: currentPos,
                  waveAnimation: _waveController.value,
                  color: const Color(0xFF053970),
                  waveHeight: 35,
                  frequency: 0.8,
                  phase: 3,
                ),
                child: Container(),
              );
            },
          ),

          // Gelombang 3 - #0060AD
          AnimatedBuilder(
            animation: Listenable.merge([
              _positionAnimation3,
              _waveController,
              if (_isFloating) _floatController else _positionController,
            ]),
            builder: (context, child) {
              final double currentPos = _getCurrentPosition(
                _positionAnimation3.value,
                0.035,
              );
              return CustomPaint(
                painter: Painter(
                  animationValue: currentPos,
                  waveAnimation: _waveController.value,
                  color: const Color(0xFF0060AD),
                  waveHeight: 32,
                  frequency: 1.0,
                  phase: 4.5,
                ),
                child: Container(),
              );
            },
          ),

          // Gelombang 4 - #019AED
          AnimatedBuilder(
            animation: Listenable.merge([
              _positionAnimation4,
              _waveController,
              if (_isFloating) _floatController else _positionController,
            ]),
            builder: (context, child) {
              final double currentPos = _getCurrentPosition(
                _positionAnimation4.value,
                0.02,
              );
              return CustomPaint(
                painter: Painter(
                  animationValue: currentPos,
                  waveAnimation: _waveController.value,
                  color: const Color(0xFF019AED),
                  waveHeight: 28,
                  frequency: 1.2,
                  phase: 2,
                ),
                child: Container(),
              );
            },
          ),

          // Konten: Logo, Teks, dan Tombol
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // LOGO
                Image.asset(
                  'assets/logo.png',
                  width: 160,
                  height: 160,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),

                // TEKS & TOMBOL - Muncul dari belakang logo
                AnimatedBuilder(
                  animation: _contentController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: Opacity(
                        opacity: _fadeAnimation.value,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              'OceQuiz',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                                    .withAlpha((0.95 * 255).round()),
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Asah pengetahuan lautmu\ndengan OceQuiz',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    Colors.white.withAlpha((0.9 * 255).round()),
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () {
                                Get.off(() => const LoginPage());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF019AED),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 8,
                                shadowColor: Colors.black26,
                              ),
                              child: const Text(
                                'Get Started',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Painter extends CustomPainter {
  final double animationValue;
  final double waveAnimation;
  final Color color;
  final double waveHeight;
  final double frequency;
  final double phase;

  Painter({
    required this.animationValue,
    required this.waveAnimation,
    required this.color,
    this.waveHeight = 30,
    this.frequency = 2,
    this.phase = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final double baseY = size.height * animationValue;

    path.moveTo(0, size.height);
    path.lineTo(0, baseY);

    final double width = size.width;
    final int points = 150;

    for (int i = 0; i <= points; i++) {
      final double x = (width * i) / points;
      final double normalizedX = (x / width) * frequency * 2 * math.pi;
      final double waveOffset =
          math.sin(normalizedX + (waveAnimation * 2 * math.pi) + phase);
      final double y = baseY + (waveOffset * waveHeight);

      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(Painter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.waveAnimation != waveAnimation;
  }
}
