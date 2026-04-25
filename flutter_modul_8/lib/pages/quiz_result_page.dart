import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/ocean_decoration.dart';
import 'home_page.dart';
import 'quiz_question_page.dart';
import 'animal_quiz_question.dart';
import 'level_two_quiz_page.dart';
import 'profile_screen.dart';

class QuizResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final String quizType; // 'daily', 'animal', 'level2'

  const QuizResultPage({
    super.key,
    required this.score,
    required this.totalQuestions,
    this.quizType = 'daily',
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (score / (totalQuestions * 10) * 100).round();
    final isPassed = percentage >= 60;

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
        child: SafeArea(
          child: Stack(
            children: [
              // Ocean decoration
              Positioned.fill(
                child: OceanBackgroundDecoration(
                  showWaves: true,
                  showBubbles: true,
                  showCreatures: true,
                  color: Colors.white,
                ),
              ),
              // Main content
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isPassed ? '🎉' : '😢',
                    style: const TextStyle(fontSize: 80),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    isPassed ? 'Selamat!' : 'Coba Lagi!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Skor Anda',
                    style: TextStyle(
                      color: Colors.white.withAlpha((0.8 * 255).round()),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$score',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$percentage%',
                    style: TextStyle(
                      color: Colors.white.withAlpha((0.8 * 255).round()),
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Widget nextPage;
                              if (quizType == 'animal') {
                                nextPage = const AnimalQuizQuestionPage();
                              } else if (quizType == 'level2') {
                                nextPage = const LevelTwoQuizPage();
                              } else {
                                nextPage = const QuizQuestionPage();
                              }
                              Get.off(() => nextPage);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3B82F6),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Ulangi Quiz',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              Get.offAll(() => const HomePage());
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: Colors.white, width: 2),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Kembali ke Home',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
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
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Get.offAll(() => const HomePage());
          }
          if (index == 2) {
            Get.offAll(() => const ProfileScreen());
          }
        },
      ),
    );
  }
}
