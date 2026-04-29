import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_modul_8/pages/home_page.dart';
import 'package:flutter_modul_8/pages/profile_screen.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/ocean_decoration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:async';

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
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxHeight: 700),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF6366F1), Color(0xFF1A0088), Color(0xFF1E1B4B)],
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
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF7C3AED), Color(0xFF6366F1)]),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text('LEADERBOARD', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: Color(0xFF7C3AED), shape: BoxShape.circle),
                          child: const Icon(Icons.close, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: Colors.white.withAlpha((0.08 * 255).round()), borderRadius: BorderRadius.circular(24)),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _buildLeaderboardItem(rank: 1, name: 'Adam', score: 42500, rankColor: const LinearGradient(colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)]), isTopThree: true),
                        const SizedBox(height: 10),
                        _buildLeaderboardItem(rank: 2, name: 'Budi', score: 35100, rankColor: const LinearGradient(colors: [Color(0xFF60A5FA), Color(0xFF3B82F6)]), isTopThree: true),
                        const SizedBox(height: 10),
                        _buildLeaderboardItem(rank: 3, name: 'Citra', score: 29305, rankColor: const LinearGradient(colors: [Color(0xFFA78BFA), Color(0xFF8B5CF6)]), isTopThree: true),
                        const SizedBox(height: 10),
                        _buildLeaderboardItem(rank: 4, name: 'Doni', score: 26280, rankColor: const LinearGradient(colors: [Color(0xFF818CF8), Color(0xFF6366F1)])),
                        const SizedBox(height: 10),
                        _buildLeaderboardItem(rank: 5, name: 'Eka', score: 19250, rankColor: const LinearGradient(colors: [Color(0xFF818CF8), Color(0xFF6366F1)])),
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

  static Widget _buildLeaderboardItem({required int rank, required String name, required int score, required Gradient rankColor, bool isTopThree = false}) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        gradient: rankColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withAlpha((0.3 * 255).round()), width: 2),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: Colors.white.withAlpha((0.25 * 255).round()), shape: BoxShape.circle),
            child: Center(child: isTopThree ? Text(rank == 1 ? '🥇' : rank == 2 ? '🥈' : '🥉', style: const TextStyle(fontSize: 18)) : Text('$rank', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold))),
          ),
          const SizedBox(width: 8),
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: const ClipOval(child: Icon(Icons.person, color: Color(0xFF1A0088), size: 20)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(name, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: Color(0xFFFBBF24), shape: BoxShape.circle), child: const Icon(Icons.star, color: Colors.white, size: 12)),
              const SizedBox(width: 4),
              Text('$score', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuizCard({required BuildContext context, required IconData icon, required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF4F46E5), Color(0xFF3730A3)]),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha((0.25 * 255).round()), blurRadius: 16, offset: const Offset(0, 8))],
        ),
        child: Column(
          children: [
            Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white.withAlpha((0.15 * 255).round()), shape: BoxShape.circle), child: Icon(icon, color: Colors.white, size: 48)),
            const SizedBox(height: 14),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
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
        decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF6366F1), Color(0xFF1A0088), Color(0xFF1E1B4B)])),
        child: Stack(
          children: [
            Positioned(bottom: 0, left: 0, right: 0, child: OceanWaves(color: Colors.white, height: 120, opacity: 0.15)),
            Positioned(top: 80, right: -30, child: OceanBubbles(count: 6, color: Colors.white)),
            Positioned(bottom: 200, left: -40, child: OceanBubbles(count: 5, color: Colors.white)),
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Hello Yurry 👋", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                              const SizedBox(height: 8),
                              Text("Ready to sharpen\nyour brain today?", style: TextStyle(color: Colors.white.withAlpha((0.85 * 255).round()), fontSize: 15, height: 1.5, fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white30, width: 2.5)),
                          child: const CircleAvatar(radius: 32, backgroundImage: AssetImage('assets/profile_pics.jpg')),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => _showLeaderboard(context),
                    child: Container(
                      width: double.infinity, margin: const EdgeInsets.symmetric(horizontal: 28),
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF4F46E5), Color(0xFF3730A3)]),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: Colors.white.withAlpha((0.3 * 255).round()), width: 2),
                      ),
                      child: Column(
                        children: [
                          const Text("🏆 High Score", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                          const SizedBox(height: 12),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("128", style: TextStyle(color: Colors.white, fontSize: 52, fontWeight: FontWeight.bold, letterSpacing: -2)),
                              SizedBox(width: 8),
                              Text("pts", style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w500)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(color: Colors.white.withAlpha((0.2 * 255).round()), borderRadius: BorderRadius.circular(12)),
                            child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.trending_up, color: Colors.white, size: 16), SizedBox(width: 6), Text("Lihat Leaderboard", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600))]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Column(
                        children: [
                          _buildQuizCard(context: context, icon: Icons.calendar_today_rounded, title: "Daily Quiz", onTap: () => Get.to(() => const DailyQuizPage())),
                          const SizedBox(height: 16),
                          _buildQuizCard(context: context, icon: Icons.eco, title: "Flora & Fauna", onTap: () => Get.to(() => const AnimalQuizPage())),
                          const SizedBox(height: 16),
                          _buildQuizCard(context: context, icon: Icons.public_rounded, title: "Oseanography", onTap: () => Get.to(() => const OseanographyQuiz())),
                          const SizedBox(height: 16),
                          _buildQuizCard(context: context, icon: Icons.flag_rounded, title: "Challenges", onTap: () => Get.to(() => const ChallengesQuizPage())),
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
          if (index == 0) Get.off(() => const HomePage());
          if (index == 2) Get.off(() => const ProfileScreen());
        },
      ),
    );
  }
}

class DailyQuizPage extends StatelessWidget {
  const DailyQuizPage({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildIntroPage(
      title: "Quiz Harian",
      description: "Selamat datang di quiz harian! Disini kalian akan mendapatkan quiz yang berbeda-beda setiap harinya!",
      icon: Icons.calendar_today_outlined,
      onStart: () => Get.to(() => const QuizQuestionPage(quizType: 'daily')),
    );
  }
}

class AnimalQuizPage extends StatelessWidget {
  const AnimalQuizPage({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildIntroPage(
      title: "Flora & Fauna 🌿🐟",
      description: "Selamat datang di kuis Flora & Fauna!\nDi sini kamu akan menemukan pertanyaan tentang tumbuhan dan hewan, baik dari laut maupun darat.",
      icon: Icons.eco,
      onStart: () => Get.to(() => const QuizQuestionPage(quizType: 'animal')),
    );
  }
}

class OseanographyQuiz extends StatelessWidget {
  const OseanographyQuiz({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildIntroPage(
      title: "Oseanography Quiz",
      description: "Selamat datang di quiz Oseanografi! Disini kalian akan mendapatkan quiz yang dipenuhi oleh berbagai daerah di lautan!",
      icon: Icons.public_rounded,
      onStart: () => Get.to(() => const QuizQuestionPage(quizType: 'ocean')),
    );
  }
}

Widget _buildIntroPage({required String title, required String description, required IconData icon, required VoidCallback onStart}) {
  return Scaffold(
    body: Container(
      width: double.infinity, height: double.infinity,
      decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF6366F1), Color(0xFF1A0088), Color(0xFF1E1B4B)])),
      child: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(child: OceanBackgroundDecoration(showWaves: true, showBubbles: true, showCreatures: true, color: Colors.white)),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    const Text("Yurry", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
                    Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white30, width: 2)), child: const CircleAvatar(radius: 32, backgroundColor: Colors.white30, backgroundImage: AssetImage('assets/profile_pics.jpg'))),
                  ]),
                ),
                const SizedBox(height: 40),
                Container(padding: const EdgeInsets.all(30), decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 2.5), borderRadius: BorderRadius.circular(20)), child: Icon(icon, color: Colors.white, size: 80)),
                const Spacer(),
                Container(
                  width: double.infinity, margin: const EdgeInsets.symmetric(horizontal: 24), padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(color: const Color(0xFF0F0A1F), borderRadius: BorderRadius.circular(28)),
                  child: Column(children: [
                    Text(title, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Text(description, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.6)),
                    const SizedBox(height: 32),
                    SizedBox(width: double.infinity, child: ElevatedButton(onPressed: onStart, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2563EB), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: const Text("Mulai", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
                  ]),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ],
        ),
      ),
    ),
    bottomNavigationBar: CustomNavBar(currentIndex: 1, onTap: (index) { if (index == 0) Get.off(() => const HomePage()); if (index == 2) Get.off(() => const ProfileScreen()); }),
  );
}

class ChallengesQuizPage extends StatelessWidget {
  const ChallengesQuizPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, height: double.infinity,
        decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF3B82F6), Color(0xFF6366F1), Color(0xFF1E1B4B)])),
        child: Stack(
          children: [
            Positioned.fill(child: OceanBackgroundDecoration(showWaves: true, showBubbles: true, showCreatures: true, color: Colors.white)),
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      const Text("Challenges", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white30, width: 2)), child: const CircleAvatar(radius: 32, backgroundImage: AssetImage('assets/profile_pics.jpg'))),
                    ]),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      children: [
                        const SizedBox(height: 24),
                        _buildLevelCard(level: 1, title: "Beginner", description: "5 soal mudah tentang kelautan", reward: "20 Poin", color: const Color(0xFF10B981), icon: Icons.emoji_events, isUnlocked: true, isCompleted: true),
                        const SizedBox(height: 24),
                        _buildLevelCard(level: 2, title: "Explorer", description: "7 soal sedang, waktu terbatas", reward: "30 Poin", color: const Color(0xFF3B82F6), icon: Icons.explore, isUnlocked: true, isCompleted: false, onTap: () => Get.to(() => const QuizQuestionPage(quizType: 'level2'))),
                        const SizedBox(height: 24),
                        _buildLevelCard(level: 3, title: "Ocean Master", description: "10 soal sulit, no hints!", reward: "50 Poin", color: const Color(0xFF8B5CF6), icon: Icons.military_tech, isUnlocked: true),
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
      bottomNavigationBar: CustomNavBar(currentIndex: 1, onTap: (index) { if (index == 0) Get.off(() => const HomePage()); if (index == 2) Get.off(() => const ProfileScreen()); }),
    );
  }

  Widget _buildLevelCard({required int level, required String title, required String description, required String reward, required Color color, required IconData icon, bool isUnlocked = false, bool isCompleted = false, VoidCallback? onTap}) {
    return InkWell(
      onTap: isUnlocked ? (onTap ?? () => Get.to(() => const QuizQuestionPage(quizType: 'daily'))) : null,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: isUnlocked ? [color, color.withAlpha(180)] : [Colors.grey.shade700, Colors.grey.shade800]),
          borderRadius: BorderRadius.circular(20),
          border: isCompleted ? Border.all(color: Colors.amber, width: 3) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white.withAlpha(50), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: Colors.white, size: 32)),
              const SizedBox(width: 16),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Level $level', style: TextStyle(color: Colors.white.withAlpha(200), fontSize: 14)), Text(title, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold))]),
            ]),
            const SizedBox(height: 16),
            Text(description, style: const TextStyle(color: Colors.white, fontSize: 15)),
            const SizedBox(height: 16),
            Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: Colors.white.withAlpha(50), borderRadius: BorderRadius.circular(12)), child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.star, color: Colors.amber, size: 20), const SizedBox(width: 6), Text(reward, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))])),
          ],
        ),
      ),
    );
  }
}

class QuizQuestionPage extends StatefulWidget {
  final String quizType;
  const QuizQuestionPage({super.key, required this.quizType});
  @override
  State<QuizQuestionPage> createState() => _QuizQuestionPageState();
}

class _QuizQuestionPageState extends State<QuizQuestionPage> {
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  bool isAnswered = false;
  int score = 0;
  int timeLeft = 30;
  Timer? timer;

  late List<Map<String, dynamic>> questions;

  @override
  void initState() {
    super.initState();
    questions = _getQuestions(widget.quizType);
    startTimer();
  }

  List<Map<String, dynamic>> _getQuestions(String type) {
    if (type == 'animal') return [
      {'question': 'Tumbuhan laut yang menyimpan karbon di sedimen adalah ...', 'answers': ['Mangrove', 'Kelp', 'Rumput Laut (Seagrass)', 'Alga Merah'], 'correctAnswer': 2, 'explanations': ['...', '...', 'Benar — seagrass menyimpan karbon di sedimen.', '...']},
      {'question': 'Produsen primer mikroskopis dasar rantai makanan laut adalah ...', 'answers': ['Zooplankton', 'Fitoplankton', 'Bakteri', 'Krill'], 'correctAnswer': 1, 'explanations': ['...', 'Benar — fitoplankton adalah produsen utama.', '...', '...']},
    ];
    if (type == 'ocean') return [
      {'question': 'Berapa persen permukaan Bumi yang ditutupi oleh lautan?', 'answers': ['50%', '60%', '71%', '85%'], 'correctAnswer': 2, 'explanations': ['...', '...', 'Benar — sekitar 71%.', '...']},
      {'question': 'Samudra terluas di dunia adalah ...', 'answers': ['Atlantik', 'Hindia', 'Arktik', 'Pasifik'], 'correctAnswer': 3, 'explanations': ['...', '...', '...', 'Benar — Pasifik terluas.']},
    ];
    if (type == 'level2') return [
      {'question': 'Zona laut yang masih dapat ditembus cahaya matahari disebut ...', 'answers': ['Fotik', 'Afotik', 'Bathyal', 'Abyssal'], 'correctAnswer': 0, 'explanations': ['Benar — zona fotik.', '...', '...', '...']},
    ];
    return [
      {'question': 'Hewan laut yang berjalan menyamping adalah ...', 'answers': ['Kepiting', 'Lobster', 'Gurita', 'Ikan Pari'], 'correctAnswer': 0, 'explanations': ['Betul — kepiting.', '...', '...', '...']},
      {'question': 'Ikan yang bersimbiosis dengan anemon adalah ...', 'answers': ['Ikan Badut', 'Ikan Hiu', 'Ikan Pari', 'Ikan Tuna'], 'correctAnswer': 0, 'explanations': ['Benar — ikan badut.', '...', '...', '...']},
    ];
  }

  void startTimer() {
    timeLeft = 30;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) setState(() => timeLeft--);
      else { timer.cancel(); if (!isAnswered) nextQuestion(); }
    });
  }

  void selectAnswer(int index) {
    if (isAnswered) return;
    setState(() { selectedAnswerIndex = index; isAnswered = true; if (index == questions[currentQuestionIndex]['correctAnswer']) score += 10; });
    timer?.cancel();
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() { currentQuestionIndex++; selectedAnswerIndex = null; isAnswered = false; });
      startTimer();
    } else {
      timer?.cancel();
      Get.off(() => QuizResultPage(score: score, totalQuestions: questions.length, quizType: widget.quizType));
    }
  }

  @override
  void dispose() { timer?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final q = questions[currentQuestionIndex];
    return Scaffold(
      body: Container(
        width: double.infinity, height: double.infinity,
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF1A0088), Color(0xFF1E1B4B)])),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(child: OceanBackgroundDecoration(showWaves: true, showBubbles: true, color: Colors.white)),
              Column(children: [
                Padding(padding: const EdgeInsets.all(24), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('Soal ${currentQuestionIndex + 1}/${questions.length}', style: const TextStyle(color: Colors.white, fontSize: 16)),
                  Text('Skor: $score', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ])),
                const SizedBox(height: 20),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 32), child: Text(q['question'], textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold))),
                const SizedBox(height: 30),
                Stack(alignment: Alignment.center, children: [
                  SizedBox(width: 80, height: 80, child: CircularProgressIndicator(value: timeLeft / 30, strokeWidth: 6, valueColor: AlwaysStoppedAnimation<Color>(timeLeft > 10 ? Colors.green : Colors.red))),
                  Text('$timeLeft', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                ]),
                const SizedBox(height: 40),
                Expanded(
                  child: ListView.builder(
                    itemCount: q['answers'].length,
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
                        child: InkWell(
                          onTap: () => selectAnswer(i),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: isAnswered
                                  ? (i == q['correctAnswer']
                                      ? Colors.green.withAlpha(100)
                                      : (i == selectedAnswerIndex
                                          ? Colors.red.withAlpha(100)
                                          : Colors.transparent))
                                  : Colors.transparent,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(q['answers'][i], style: const TextStyle(color: Colors.white, fontSize: 18)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (isAnswered) Padding(padding: const EdgeInsets.all(32), child: ElevatedButton(onPressed: nextQuestion, child: const Text("Next"))),
                const SizedBox(height: 80),
              ]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar(currentIndex: 1, onTap: (index) { timer?.cancel(); if (index == 0) Get.off(() => const HomePage()); if (index == 2) Get.off(() => const ProfileScreen()); if (index == 1) Get.off(() => const QuizListPage()); }),
    );
  }
}

class QuizResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final String quizType;
  const QuizResultPage({super.key, required this.score, required this.totalQuestions, required this.quizType});
  @override
  Widget build(BuildContext context) {
    final perc = (score / (totalQuestions * 10) * 100).round();
    return Scaffold(
      body: Container(
        width: double.infinity, height: double.infinity,
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF1A0088), Color(0xFF1E1B4B)])),
        child: SafeArea(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(perc >= 60 ? '🎉' : '😢', style: const TextStyle(fontSize: 80)),
            Text(perc >= 60 ? 'Selamat!' : 'Coba Lagi!', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('Skor Anda: $score ($perc%)', style: const TextStyle(color: Colors.white, fontSize: 24)),
            const SizedBox(height: 48),
            ElevatedButton(onPressed: () => Get.off(() => QuizQuestionPage(quizType: quizType)), child: const Text('Ulangi Quiz')),
            const SizedBox(height: 16),
            OutlinedButton(onPressed: () => Get.offAll(() => const HomePage()), child: const Text('Kembali ke Home', style: TextStyle(color: Colors.white))),
          ]),
        ),
      ),
      bottomNavigationBar: CustomNavBar(currentIndex: 1, onTap: (index) { if (index == 0) Get.offAll(() => const HomePage()); if (index == 2) Get.offAll(() => const ProfileScreen()); }),
    );
  }
}
