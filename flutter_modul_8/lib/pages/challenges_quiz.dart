import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_modul_8/pages/home_page.dart';
import 'package:flutter_modul_8/pages/profile_screen.dart';
import 'package:flutter_modul_8/pages/quiz_question_page.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/ocean_decoration.dart';
import 'level_two_quiz_page.dart';

class ChallengesQuizPage extends StatelessWidget {
  const ChallengesQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3B82F6),
              Color(0xFF6366F1),
              Color(0xFF1E1B4B),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Ocean decoration background
            Positioned.fill(
              child: OceanBackgroundDecoration(
                showWaves: true,
                showBubbles: true,
                showCreatures: true,
                color: Colors.white,
              ),
            ),
            // Main content
            SafeArea(
              child: Column(
                children: [
                  // Header dengan nama dan avatar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Challenges",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white30, width: 2),
                          ),
                          child: const CircleAvatar(
                            radius: 32,
                            backgroundColor: Colors.white30,
                            backgroundImage:
                                AssetImage('assets/profile_pics.jpg'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Level Cards
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      children: [
                        const SizedBox(height: 24),
                        _buildLevelCard(
                          context: context,
                          level: 1,
                          title: "Beginner",
                          description: "5 soal mudah tentang kelautan",
                          reward: "20 Poin",
                          color: const Color(0xFF10B981), // Green
                          icon: Icons.emoji_events,
                          isUnlocked: true,
                          isCompleted: true,
                        ),
                        const SizedBox(height: 24),
                        _buildLevelCard(
                          context: context,
                          level: 2,
                          title: "Explorer",
                          description: "7 soal sedang, waktu terbatas",
                          reward: "30 Poin",
                          color: const Color(0xFF3B82F6), // Blue
                          icon: Icons.explore,
                          isUnlocked: true,
                          isCompleted: false,
                          onTap: () {
                            Get.to(() => const LevelTwoQuizPage());
                          },
                        ),
                        const SizedBox(height: 24),
                        _buildLevelCard(
                          context: context,
                          level: 3,
                          title: "Ocean Master",
                          description: "10 soal sulit, no hints!",
                          reward: "50 Poin",
                          color: const Color(0xFF8B5CF6), // Purple
                          icon: Icons.military_tech,
                          isUnlocked: true,
                          isCompleted: false,
                        ),
                        const SizedBox(height: 24),
                        _buildLevelCard(
                          context: context,
                          level: 4,
                          title: "Deep Sea Expert",
                          description: "15 soal expert, 10 detik/soal",
                          reward: "100 Poin",
                          color: const Color(0xFFF59E0B), // Orange
                          icon: Icons.workspace_premium,
                          isUnlocked: false,
                          isCompleted: false,
                        ),
                        const SizedBox(height: 24),
                        _buildLevelCard(
                          context: context,
                          level: 5,
                          title: "Legendary",
                          description: "20 soal ultimate challenge",
                          reward: "200 Poin",
                          color: const Color(0xFFEF4444), // Red
                          icon: Icons.stars,
                          isUnlocked: false,
                          isCompleted: false,
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Get.off(() => const HomePage());
          }
          if (index == 2) {
            Get.off(() => const ProfileScreen());
          }
        },
      ),
    );
  }

  Widget _buildLevelCard({
    required BuildContext context,
    required int level,
    required String title,
    required String description,
    required String reward,
    required Color color,
    required IconData icon,
    required bool isUnlocked,
    required bool isCompleted,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: isUnlocked
          ? (onTap ??
              () {
                Get.to(() => const QuizQuestionPage());
              })
          : null,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isUnlocked
                ? [color, color.withAlpha((0.7 * 255).round())]
                : [Colors.grey.shade700, Colors.grey.shade800],
          ),
          borderRadius: BorderRadius.circular(20),
          border:
              isCompleted ? Border.all(color: Colors.amber, width: 3) : null,
          boxShadow: [
            BoxShadow(
              color: isUnlocked
                  ? color.withAlpha((0.4 * 255).round())
                  : Colors.black.withAlpha((0.3 * 255).round()),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Lock overlay untuk level yang belum terbuka
            if (!isUnlocked)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha((0.5 * 255).round()),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.lock,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
              ),

            // Completed badge
            if (isCompleted)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'Completed',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Icon level
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha((0.2 * 255).round()),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Level $level',
                            style: TextStyle(
                              color:
                                  Colors.white.withAlpha((0.8 * 255).round()),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withAlpha((0.9 * 255).round()),
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                // Reward badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha((0.2 * 255).round()),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFBBF24),
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        reward,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
