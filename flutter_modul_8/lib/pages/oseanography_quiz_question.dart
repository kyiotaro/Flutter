import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_modul_8/pages/profile_screen.dart';
import 'package:flutter_modul_8/pages/quiz_page.dart';
import 'dart:async';
import '../widgets/custom_navbar.dart';
import '../widgets/ocean_decoration.dart';
import 'home_page.dart';
import 'quiz_result_page.dart';

class OseanographyQuizQuestion extends StatefulWidget {
  const OseanographyQuizQuestion({super.key});

  @override
  State<OseanographyQuizQuestion> createState() =>
      _OseanographyQuizQuestionState();
}

class _OseanographyQuizQuestionState extends State<OseanographyQuizQuestion> {
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  bool isAnswered = false;
  int score = 0;
  int timeLeft = 30;
  Timer? timer;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Berapa persen permukaan Bumi yang ditutupi oleh lautan?',
      'answers': ['50%', '60%', '71%', '85%'],
      'correctAnswer': 2,
      'explanations': [
        '50% terlalu rendah; luas lautan lebih besar dari itu.',
        '60% masih kurang dari angka yang sebenarnya.',
        'Benar — sekitar 71% permukaan Bumi ditutupi oleh lautan.',
        '85% terlalu tinggi; angka yang umum digunakan adalah sekitar 71%.',
      ],
    },
    {
      'question': 'Samudra terluas di dunia adalah ...',
      'answers': [
        'Samudra Atlantik',
        'Samudra Hindia',
        'Samudra Arktik',
        'Samudra Pasifik'
      ],
      'correctAnswer': 3,
      'explanations': [
        'Atlantik besar tetapi bukan yang terbesar.',
        'Hindia lebih kecil dari Pasifik.',
        'Arktik adalah yang terkecil.',
        'Benar — Pasifik adalah samudra terluas di dunia.',
      ],
    },
    {
      'question':
          'Lapisan laut paling dangkal yang masih terkena cahaya matahari disebut zona ...',
      'answers': ['Abisal', 'Hadal', 'Fotik', 'Batial'],
      'correctAnswer': 2,
      'explanations': [
        'Abisal adalah zona dalam yang gelap.',
        'Hadal adalah zona paling dalam (palung).',
        'Benar — zona fotik menerima cahaya matahari sehingga fotosintesis bisa terjadi.',
        'Batial adalah zona lebih dalam dari fotik tapi tidak setengah dalam seperti abisal.',
      ],
    },
    {
      'question':
          'Peristiwa naik turunnya permukaan air laut secara periodik disebut ...',
      'answers': ['Gelombang', 'Pasang surut', 'Arus laut', 'Tsunami'],
      'correctAnswer': 1,
      'explanations': [
        'Gelombang disebabkan angin di permukaan, bukan pergerakan periodik besar.',
        'Benar — pasang surut disebabkan oleh gaya gravitasi Bulan dan Matahari.',
        'Arus laut adalah aliran air, bukan naik-turun periodik.',
        'Tsunami adalah gelombang besar akibat gempa atau longsor bawah laut, bukan pasang surut biasa.',
      ],
    },
    {
      'question':
          'Alat yang digunakan untuk mengukur kedalaman laut adalah ...',
      'answers': ['Barometer', 'Termometer', 'Sonar', 'Anemometer'],
      'correctAnswer': 2,
      'explanations': [
        'Barometer mengukur tekanan udara, bukan kedalaman laut.',
        'Termometer mengukur suhu.',
        'Benar — sonar (sound navigation and ranging) sering digunakan untuk mengukur kedalaman.',
        'Anemometer mengukur kecepatan angin.',
      ],
    },
    {
      'question':
          'Gelombang laut besar yang disebabkan oleh gempa bawah laut disebut ...',
      'answers': ['Arus laut', 'Tsunami', 'Pasang naik', 'Ombak pantai'],
      'correctAnswer': 1,
      'explanations': [
        'Arus laut adalah aliran air, bukan gelombang yang disebabkan gempa.',
        'Benar — tsunami biasanya dipicu oleh gempa bawah laut atau longsor bawah air.',
        'Pasang naik adalah fenomena pasang surut, bukan tsunami.',
        'Ombak pantai disebabkan angin dan faktor lokal, tidak sama dengan tsunami.',
      ],
    },
    {
      'question':
          'Arus laut panas terbesar di dunia yang berada di Samudra Atlantik adalah ...',
      'answers': ['Kuroshio', 'Gulf Stream', 'Oyashio', 'Agulhas'],
      'correctAnswer': 1,
      'explanations': [
        'Kuroshio adalah arus di Pasifik barat.',
        'Benar — Gulf Stream adalah arus hangat besar di Atlantik yang mempengaruhi iklim.',
        'Oyashio adalah arus dingin di Pasifik barat laut.',
        'Agulhas adalah arus di selatan Afrika, tetapi Gulf Stream lebih dikenal sebagai arus panas besar di Atlantik.',
      ],
    },
    {
      'question':
          'Zona laut yang sangat dalam dan tidak mendapat cahaya matahari disebut ...',
      'answers': ['Litoral', 'Neritik', 'Abisal', 'Fotik'],
      'correctAnswer': 2,
      'explanations': [
        'Litoral adalah zona tepi pantai.',
        'Neritik adalah zona dangkal di atas landas kontinen.',
        'Benar — abisal adalah zona sangat dalam yang hampir tidak menerima cahaya.',
        'Fotik adalah zona yang menerima cahaya.',
      ],
    },
    {
      'question': 'Batas pertemuan antara daratan dan laut disebut zona ...',
      'answers': ['Litoral', 'Batial', 'Abisal', 'Pelagik'],
      'correctAnswer': 0,
      'explanations': [
        'Benar — litoral adalah zona pesisir tempat daratan bertemu laut.',
        'Batial adalah zona lebih dalam daripada litoral.',
        'Abisal adalah zona sangat dalam.',
        'Pelagik mengacu pada kolom air lepas pantai, bukan batas darat-laut.',
      ],
    },
    {
      'question': 'Kandungan garam dalam air laut disebut ...',
      'answers': ['Salinitas', 'Evaporasi', 'Presipitasi', 'Konduksi'],
      'correctAnswer': 0,
      'explanations': [
        'Benar — salinitas adalah ukuran kandungan garam dalam air laut.',
        'Evaporasi adalah proses penguapan, bukan ukuran garam.',
        'Presipitasi berkaitan dengan hujan atau pengendapan.',
        'Konduksi adalah perpindahan panas, bukan kandungan garam.',
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timeLeft = 30;
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
      Get.off(() => QuizResultPage(
            score: score,
            totalQuestions: questions.length,
            quizType: 'animal',
          ));
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
                children: [
                  // Header dengan progress
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Soal ${currentQuestionIndex + 1}/${questions.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
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
                  ),

                  const SizedBox(height: 20),

                  // Question text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      currentQuestion['question'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
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
                          value: timeLeft / 30,
                          strokeWidth: 6,
                          backgroundColor:
                              Colors.white.withAlpha((0.2 * 255).round()),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            timeLeft > 10 ? Colors.green : Colors.red,
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
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
