import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_modul_8/pages/animal_quiz.dart';
import 'package:flutter_modul_8/pages/challenges_quiz.dart';
import 'package:flutter_modul_8/pages/daily_quiz.dart';
import 'package:flutter_modul_8/pages/oseanography_quiz.dart';
import 'package:flutter_modul_8/pages/home_page.dart';
import 'package:flutter_modul_8/pages/profile_screen.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/ocean_decoration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class QuizHistoryService {
  static Future<void> saveQuizResult({
    required String quizTitle,
    required String score,
    required String status,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getString('quiz_history') ?? '[]';
      final List<dynamic> history = jsonDecode(historyJson);

      final newEntry = {
        'title': quizTitle,
        'score': score,
        'status': status,
        'date': DateFormat('MMM dd, yyyy - HH:mm').format(DateTime.now()),
      };

      history.add(newEntry);
      await prefs.setString('quiz_history', jsonEncode(history));
    } catch (e) {
      print('Error saving quiz history: $e');
    }
  }
}

class QuizListPage extends StatelessWidget {
  const QuizListPage({super.key});

  void _showLeaderboard(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxHeight: 700),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF6366F1),
                  Color(0xFF1A0088),
                  Color(0xFF1E1B4B),
                ],
              ),
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((0.3 * 255).round()),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header dengan banner
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF7C3AED),
                            Color(0xFF6366F1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha((0.2 * 255).round()),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Text(
                        'LEADERBOARD',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Color(0xFF7C3AED),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Leaderboard List
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha((0.08 * 255).round()),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _buildLeaderboardItem(
                          rank: 1,
                          name: 'Adam',
                          score: 42500,
                          rankColor: const LinearGradient(
                            colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
                          ),
                          isTopThree: true,
                        ),
                        const SizedBox(height: 10),
                        _buildLeaderboardItem(
                          rank: 2,
                          name: 'Budi',
                          score: 35100,
                          rankColor: const LinearGradient(
                            colors: [Color(0xFF60A5FA), Color(0xFF3B82F6)],
                          ),
                          isTopThree: true,
                        ),
                        const SizedBox(height: 10),
                        _buildLeaderboardItem(
                          rank: 3,
                          name: 'Citra',
                          score: 29305,
                          rankColor: const LinearGradient(
                            colors: [Color(0xFFA78BFA), Color(0xFF8B5CF6)],
                          ),
                          isTopThree: true,
                        ),
                        const SizedBox(height: 10),
                        _buildLeaderboardItem(
                          rank: 4,
                          name: 'Doni',
                          score: 26280,
                          rankColor: const LinearGradient(
                            colors: [Color(0xFF818CF8), Color(0xFF6366F1)],
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildLeaderboardItem(
                          rank: 5,
                          name: 'Eka',
                          score: 19250,
                          rankColor: const LinearGradient(
                            colors: [Color(0xFF818CF8), Color(0xFF6366F1)],
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildLeaderboardItem(
                          rank: 6,
                          name: 'Fira',
                          score: 16890,
                          rankColor: const LinearGradient(
                            colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildLeaderboardItem(
                          rank: 7,
                          name: 'Gina',
                          score: 15020,
                          rankColor: const LinearGradient(
                            colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildLeaderboardItem(
                          rank: 8,
                          name: 'Hasan',
                          score: 11000,
                          rankColor: const LinearGradient(
                            colors: [Color(0xFF4F46E5), Color(0xFF4338CA)],
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildLeaderboardItem(
                          rank: 9,
                          name: 'Indra',
                          score: 10591,
                          rankColor: const LinearGradient(
                            colors: [Color(0xFF4338CA), Color(0xFF3730A3)],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _buildLeaderboardItem({
    required int rank,
    required String name,
    required int score,
    required Gradient rankColor,
    bool isTopThree = false,
  }) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      decoration: BoxDecoration(
        gradient: rankColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withAlpha((0.3 * 255).round()),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.15 * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Rank dengan medal untuk top 3
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha((0.25 * 255).round()),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isTopThree
                  ? Text(
                      rank == 1
                          ? '🥇'
                          : rank == 2
                              ? '🥈'
                              : '🥉',
                      style: const TextStyle(fontSize: 18),
                    )
                  : Text(
                      '$rank',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 8),
          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            child: ClipOval(
              child: Icon(
                Icons.person,
                color: Colors.blue.shade700,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Name - Expanded
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          // Score with icon
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFFFBBF24),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 12,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '$score',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuizCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4F46E5),
              Color(0xFF3730A3),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.25 * 255).round()),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha((0.15 * 255).round()),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 48,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

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
              Color(0xFF6366F1),
              Color(0xFF1A0088),
              Color(0xFF1E1B4B),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Dekorasi gelombang laut
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: OceanWaves(
                color: Colors.white,
                height: 120,
                opacity: 0.15,
              ),
            ),
            // Dekorasi gelembung
            Positioned(
              top: 80,
              right: -30,
              child: OceanBubbles(
                count: 6,
                color: Colors.white,
              ),
            ),
            Positioned(
              bottom: 200,
              left: -40,
              child: OceanBubbles(
                count: 5,
                color: Colors.white,
              ),
            ),
            // Konten utama
            SafeArea(
              child: Column(
                children: [
                  // Header dengan greeting dan avatar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Hello Yurry 👋",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Ready to sharpen\nyour brain today?",
                                style: TextStyle(
                                  color: Colors.white
                                      .withAlpha((0.85 * 255).round()),
                                  fontSize: 15,
                                  height: 1.5,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Colors.white30, width: 2.5),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    Colors.black.withAlpha((0.3 * 255).round()),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 32,
                            backgroundImage:
                                AssetImage('assets/profile_pics.jpg'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // High Score Card - Leaderboard Button
                  GestureDetector(
                    onTap: () => _showLeaderboard(context),
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 28),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF4F46E5),
                            Color(0xFF3730A3),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha((0.5 * 255).round()),
                            blurRadius: 28,
                            offset: const Offset(0, 14),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withAlpha((0.3 * 255).round()),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "🏆 High Score",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "128",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 52,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -2,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "pts",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color:
                                  Colors.white.withAlpha((0.2 * 255).round()),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.trending_up,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "Lihat Leaderboard",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Quiz Menu Cards - Vertical List
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Column(
                        children: [
                          _buildQuizCard(
                            context: context,
                            icon: Icons.calendar_today_rounded,
                            title: "Daily Quiz",
                            onTap: () {
                              Get.to(() => const DailyQuizPage());
                            },
                          ),
                          const SizedBox(height: 16),
                          _buildQuizCard(
                            context: context,
                            icon: Icons.eco,
                            title: "Flora & Fauna",
                            onTap: () {
                              Get.to(() => const AnimalQuizPage());
                            },
                          ),
                          const SizedBox(height: 16),
                          _buildQuizCard(
                            context: context,
                            icon: Icons.public_rounded,
                            title: "Oseanography",
                            onTap: () {
                              Get.to(() => const OseanographyQuiz());
                            },
                          ),
                          const SizedBox(height: 16),
                          _buildQuizCard(
                            context: context,
                            icon: Icons.flag_rounded,
                            title: "Challenges",
                            onTap: () {
                              Get.to(() => const ChallengesQuizPage());
                            },
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
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
          } else if (index == 2) {
            Get.off(() => const ProfileScreen());
          }
        },
      ),
    );
  }
}
