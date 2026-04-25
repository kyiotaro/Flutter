import 'package:flutter/material.dart';
import 'package:flutter_modul_8/pages/profile_screen.dart';
import 'package:flutter_modul_8/pages/quiz_page.dart';
import 'dart:async';
import '../widgets/custom_navbar.dart';
import '../widgets/ocean_decoration.dart';
import 'home_page.dart';
import 'quiz_result_page.dart';

class LevelTwoQuizPage extends StatefulWidget {
  const LevelTwoQuizPage({super.key});

  @override
  State<LevelTwoQuizPage> createState() => _LevelTwoQuizPageState();
}

class _LevelTwoQuizPageState extends State<LevelTwoQuizPage> {
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  bool isAnswered = false;
  int score = 0;
  int timeLeft = 25; // 25 detik untuk level sedang
  Timer? timer;

  final List<Map<String, dynamic>> questions = [
    {
      'question':
          'Zona laut yang masih dapat ditembus cahaya matahari disebut zona ...',
      'answers': ['Fotik', 'Afotik', 'Bathyal', 'Abyssal'],
      'correctAnswer': 0,
      'explanations': [
        'Benar — zona fotik menerima cahaya matahari sehingga fotosintesis dapat terjadi.',
        'Afotik berarti tanpa cahaya.',
        'Bathyal adalah zona yang lebih dalam daripada fotik tetapi tidak sedalam abisal.',
        'Abyssal (abisal) adalah zona yang sangat dalam dan gelap.',
      ],
    },
    {
      'question':
          'Ekosistem perairan payau yang terbentuk di muara sungai disebut ...',
      'answers': ['Terumbu Karang', 'Estuari', 'Laguna', 'Delta'],
      'correctAnswer': 1,
      'explanations': [
        'Terumbu karang adalah ekosistem laut tropis, bukan muara.',
        'Benar — estuari terbentuk di muara sungai dan merupakan area pertemuan air tawar dan asin.',
        'Laguna adalah badan air yang terpisah dari laut oleh barisan pasir atau batu.',
        'Delta adalah bentuk lahan di muara sungai yang terbentuk dari sedimen, bukan istilah umum untuk ekosistem payau.',
      ],
    },
    {
      'question':
          'Hewan laut yang termasuk dalam kelompok Cephalopoda adalah ...',
      'answers': ['Kepiting', 'Ubur-ubur', 'Cumi-cumi', 'Bintang Laut'],
      'correctAnswer': 2,
      'explanations': [
        'Kepiting termasuk arthropoda, bukan cephalopoda.',
        'Ubur-ubur termasuk cnidarian, bukan cephalopoda.',
        'Benar — cumi-cumi adalah cephalopoda, kelompok yang juga mencakup gurita dan sotong.',
        'Bintang laut adalah echinodermata, bukan cephalopoda.',
      ],
    },
    {
      'question': 'Palung laut terdalam di dunia adalah Palung ...',
      'answers': ['Sunda', 'Mariana', 'Puerto Rico', 'Jawa'],
      'correctAnswer': 1,
      'explanations': [
        'Palung Sunda tidak se-dalam Mariana.',
        'Benar — Palung Mariana adalah palung terdalam di dunia.',
        'Palung Puerto Rico dalam tetapi bukan yang terdalam.',
        'Palung Jawa bukan yang terdalam.',
      ],
    },
    {
      'question':
          'Hewan laut yang memiliki exoskeleton dari zat kitin adalah ...',
      'answers': ['Ikan Pari', 'Udang', 'Ubur-ubur', 'Paus'],
      'correctAnswer': 1,
      'explanations': [
        'Ikan pari tidak memiliki eksoskeleton kitin.',
        'Benar — udang memiliki eksoskeleton yang sebagian besar tersusun dari kitin.',
        'Ubur-ubur memiliki tubuh berair dan tidak memiliki eksoskeleton.',
        'Paus adalah mamalia dan tidak memiliki eksoskeleton.',
      ],
    },
    {
      'question':
          'Proses perpindahan air laut akibat perbedaan suhu dan salinitas disebut ...',
      'answers': [
        'Arus Permukaan',
        'Arus Thermohaline',
        'Gelombang',
        'Pasang Surut'
      ],
      'correctAnswer': 1,
      'explanations': [
        'Arus permukaan dipengaruhi angin dan kondisi permukaan.',
        'Benar — arus thermohaline (sirkulasi termohalin) disebabkan oleh perbedaan suhu dan salinitas.',
        'Gelombang berkaitan dengan angin dan gangguan permukaan.',
        'Pasang surut adalah fenomena gravitasi Bulan dan Matahari.',
      ],
    },
    {
      'question':
          'Hewan laut yang dapat menghasilkan cahaya sendiri (bioluminescence) adalah ...',
      'answers': ['Hiu Putih', 'Ikan Badut', 'Cumi-cumi Raksasa', 'Ubur-ubur'],
      'correctAnswer': 3,
      'explanations': [
        'Hiu putih tidak umum menghasilkan cahaya sendiri.',
        'Ikan badut tidak terkenal untuk bioluminesensi.',
        'Beberapa cumi-cumi besar memiliki kemampuan bioluminesensi, namun jawaban yang lebih tepat di sini adalah ubur-ubur tergantung spesis.',
        'Benar — beberapa ubur-ubur dan organisme laut lainnya menunjukkan bioluminesensi.',
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timeLeft = 25; // 25 detik untuk level sedang
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer.cancel();
        // Auto move to next question when time's up
        if (!isAnswered) {
          nextQuestion();
        }
      }
    });
  }

  void selectAnswer(int index) {
    if (isAnswered) return;

    setState(() {
      selectedAnswerIndex = index;
      isAnswered = true;

      // Check if answer is correct
      if (index == questions[currentQuestionIndex]['correctAnswer']) {
        score += 10;
      }
    });

    timer?.cancel();
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
        isAnswered = false;
      });
      startTimer();
    } else {
      // Quiz finished, go to result page
      timer?.cancel();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizResultPage(
            score: score,
            totalQuestions: questions.length,
            quizType: 'level2',
          ),
        ),
      );
    }
  }

  Color getAnswerColor(int index) {
    if (!isAnswered) {
      return Colors.transparent;
    }

    // If this is the correct answer, always show green
    if (index == questions[currentQuestionIndex]['correctAnswer']) {
      return Colors.green;
    }

    // If this is the selected wrong answer, show red
    if (index == selectedAnswerIndex) {
      return Colors.red;
    }

    return Colors.transparent;
  }

  Color getAnswerBorderColor(int index) {
    if (!isAnswered) {
      return Colors.white;
    }

    // If this is the correct answer, show green border
    if (index == questions[currentQuestionIndex]['correctAnswer']) {
      return Colors.green;
    }

    // If this is the selected wrong answer, show red border
    if (index == selectedAnswerIndex) {
      return Colors.red;
    }

    return Colors.white;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    // Prepare explanation text to show after answering
    String explanationText = '';
    final int correctIndex = currentQuestion['correctAnswer'] as int;
    final List? explanations = currentQuestion['explanations'] as List?;
    if (isAnswered && selectedAnswerIndex != null) {
      if (explanations != null && selectedAnswerIndex! < explanations.length) {
        explanationText = explanations[selectedAnswerIndex!];
      } else if (explanations != null && correctIndex < explanations.length) {
        explanationText =
            'Jawaban salah. Jawaban yang benar adalah "${currentQuestion['answers'][correctIndex]}".\nPenjelasan: ${explanations[correctIndex]}';
      } else {
        explanationText =
            'Jawaban salah. Jawaban yang benar adalah "${currentQuestion['answers'][correctIndex]}".';
      }
    }

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
                children: [
                  // Header dengan progress
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3B82F6),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Level 2: Explorer',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'Skor: $score',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Progress bar
                        Row(
                          children: [
                            Text(
                              'Soal ${currentQuestionIndex + 1}/${questions.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: (currentQuestionIndex + 1) /
                                      questions.length,
                                  backgroundColor: Colors.white
                                      .withAlpha((0.3 * 255).round()),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    Color(0xFF3B82F6),
                                  ),
                                  minHeight: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Question text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      currentQuestion['question'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Timer dengan circular progress
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          value: timeLeft / 25,
                          strokeWidth: 6,
                          backgroundColor:
                              Colors.white.withAlpha((0.2 * 255).round()),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            timeLeft > 10
                                ? const Color(0xFF3B82F6)
                                : timeLeft > 5
                                    ? Colors.orange
                                    : Colors.red,
                          ),
                        ),
                      ),
                      Text(
                        '$timeLeft',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Answer options
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        children: List.generate(
                          currentQuestion['answers'].length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildAnswerButton(
                              currentQuestion['answers'][index],
                              index,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Explanation area
                  if (isAnswered && selectedAnswerIndex != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: (selectedAnswerIndex ==
                                      currentQuestion['correctAnswer'])
                                  ? Colors.green.withAlpha((0.12 * 255).round())
                                  : Colors.red.withAlpha((0.12 * 255).round()),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: (selectedAnswerIndex ==
                                        currentQuestion['correctAnswer'])
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            child: Text(
                              explanationText,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  nextQuestion();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4F46E5),
                                  foregroundColor: Colors.white,
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                ),
                                child: const Text('Next'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 80),
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
            timer?.cancel();
            Get.off(() => const HomePage());
          }
          if (index == 2) {
            timer?.cancel();
            Get.off(() => const ProfileScreen());
          }
          if (index == 1) {
            timer?.cancel();
            Get.off(() => const QuizListPage());
          }
        },
      ),
    );
  }

  Widget _buildAnswerButton(String answer, int index) {
    return InkWell(
      onTap: () => selectAnswer(index),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        decoration: BoxDecoration(
          color: getAnswerColor(index).withAlpha((0.3 * 255).round()),
          border: Border.all(
            color: getAnswerBorderColor(index),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          answer,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
AnswerColor(index).withAlpha((0.3 * 255).round()),
          border: Border.all(
            color: getAnswerBorderColor(index),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          answer,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
