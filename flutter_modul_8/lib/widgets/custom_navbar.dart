import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_modul_8/pages/home_page.dart';
import 'package:flutter_modul_8/pages/profile_screen.dart';
import 'package:flutter_modul_8/pages/quiz_page.dart';

class CustomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _scaleAnimations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 320),
        vsync: this,
      ),
    );

    _scaleAnimations = _controllers
        .map(
          (controller) => Tween<double>(begin: 1.0, end: 1.15).animate(
            CurvedAnimation(parent: controller, curve: Curves.elasticOut),
          ),
        )
        .toList();

    // Animate selected item
    _controllers[widget.currentIndex].forward();
  }

  @override
  void didUpdateWidget(CustomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _controllers[oldWidget.currentIndex].reverse();
      _controllers[widget.currentIndex].forward();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.1 * 255).round()),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: const Color(0xFF4F46E5),
        unselectedItemColor: Colors.grey.shade400,
        currentIndex: widget.currentIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          // Play tap animation immediately
          for (var i = 0; i < _controllers.length; i++) {
            if (i == index) {
              _controllers[i].forward(from: 0.0);
            } else {
              _controllers[i].reverse();
            }
          }

          // Small delay so the animation is visible before navigation/callback
          Future.delayed(const Duration(milliseconds: 320), () {
            if (widget.onTap != null) {
              widget.onTap!(index);
            } else {
              // Default navigation
              // Index 0 = Home, Index 1 = Quiz List, Index 2 = Profile
              if (index == 0) {
                Get.off(() => const HomePage());
              } else if (index == 1) {
                Get.off(() => const QuizListPage());
              } else if (index == 2) {
                Get.off(() => const ProfileScreen());
              }
            }
          });
        },
        items: [
          // Index 0 - Home (kiri)
          BottomNavigationBarItem(
            icon: _buildAnimatedIcon(0, Icons.home_outlined),
            activeIcon: _buildAnimatedIcon(0, Icons.home),
            label: '',
          ),
          // Index 1 - Quiz List (tengah)
          BottomNavigationBarItem(
            icon: _buildAnimatedIcon(1, Icons.menu_book_outlined),
            activeIcon: _buildAnimatedIcon(1, Icons.menu_book),
            label: '',
          ),
          // Index 2 - Profile (kanan)
          BottomNavigationBarItem(
            icon: _buildAnimatedIcon(2, Icons.person_outline),
            activeIcon: _buildAnimatedIcon(2, Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedIcon(int index, IconData icon) {
    return ScaleTransition(
      scale: _scaleAnimations[index],
      child: Icon(icon, size: 26),
    );
  }
}
