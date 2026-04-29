import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../widgets/custom_navbar.dart';
import '../widgets/ocean_decoration.dart';
import 'home_page.dart';
import 'profile_screen.dart';
import 'quiz_page.dart';
import 'quiz_result_page.dart';

class AnimalQuizQuestionPage extends StatefulWidget {
  const AnimalQuizQuestionPage({super.key});

  @override
  State<AnimalQuizQuestionPage> createState() => _AnimalQuizQuestionPageState();
}

class _AnimalQuizQuestionPageState extends State<AnimalQuizQuestionPage> {
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  bool isAnswered = false;
  int score = 0;
  int timeLeft = 30;
  Timer? timer;

  final List<Map<String, dynamic>> questions = [
    {
      'question':
          'Tumbuhan laut yang menyimpan karbon di sedimen dan menjadi habitat penting adalah ...',
      'answers': ['Mangrove', 'Kelp', 'Rumput Laut (Seagrass)', 'Alga Merah'],
      'correctAnswer': 2,
      'explanations': [
        'Mangrove penting di zona pesisir, tetapi rumput laut (seagrass) adalah yang menyimpan karbon di sedimen laut.',
        'Kelp adalah ganggang besar yang membentuk hutan laut di perairan dingin, tetapi bukan yang paling dikenal menyimpan karbon sedimen.',
        'Benar — seagrass menyimpan karbon di sedimen dan menyediakan habitat bagi banyak organisme.',
        'Alga merah penting secara ekologis, namun fungsi penyimpanan karbon spesifik berbeda dari seagrass.',
      ],
    },
    {
      'question':
          'Produsen primer mikroskopis yang menjadi dasar rantai makanan laut adalah ...',
      'answers': ['Zooplankton', 'Fitoplankton', 'Bakteri pengurai', 'Krill'],
      'correctAnswer': 1,
      'explanations': [
        'Zooplankton adalah konsumen, bukan produsen.',
        'Benar — fitoplankton melakukan fotosintesis dan menjadi produsen utama.',
        'Beberapa bakteri melakukan fotosintesis tetapi fitoplankton adalah jawaban utama.',
        'Krill adalah konsumen yang memakan fitoplankton.',
      ],
    },
    {
      'question':
          'Hubungan simbiosis penting di terumbu karang antara karang dan alga disebut ...',
      'answers': [
        'Mutualisme karang-anemon',
        'Komensalisme',
        'Karang & zooxanthellae',
        'Parasitisme'
      ],
      'correctAnswer': 2,
      'explanations': [
        'Ikan badut & anemon adalah mutualisme tetapi berbeda konteksnya.',
        'Komensalisme bukan hubungan fotosintetik utama pada karang.',
        'Benar — zooxanthellae memberikan nutrisi lewat fotosintesis kepada karang.',
        'Parasitisme bukan hubungan yang dimaksud.',
      ],
    },
    {
      'question':
          'Ekosistem yang sering menjadi nursery bagi ikan-ikan muda adalah ...',
      'answers': [
        'Samudra terbuka',
        'Estuari & laguna',
        'Padang pasir',
        'Gunung laut'
      ],
      'correctAnswer': 1,
      'explanations': [
        'Samudra terbuka kurang terlindungi untuk nursery anak ikan.',
        'Benar — estuari dan laguna menyediakan makanan dan perlindungan untuk ikan muda.',
        'Padang pasir bukan ekosistem laut.',
        'Gunung laut (seamount) berbeda fungsi; nursery lebih terkait estuari/laguna.',
      ],
    },
    {
      'question':
          'Ganggang besar yang membentuk hutan laut di perairan dingin disebut ...',
      'answers': ['Kelp', 'Seagrass', 'Zooxanthellae', 'Sargassum'],
      'correctAnswer': 0,
      'explanations': [
        'Benar — kelp membentuk hutan bawah air yang mendukung keanekaragaman hayati.',
        'Seagrass adalah tanaman berbunga di dasar berpasir, bukan ganggang besar seperti kelp.',
        'Zooxanthellae adalah alga mikroskopis simbion pada karang.',
        'Sargassum membentuk hamparan mengapung, bukan hutan seperti kelp.',
      ],
    },
    {
      'question':
          'Organisme laut yang sering menunjukkan bioluminesensi adalah ...',
      'answers': ['Gurita', 'Ubur-ubur tertentu', 'Ikan pari', 'Kepiting'],
      'correctAnswer': 1,
      'explanations': [
        'Beberapa gurita memang bercahaya, tapi ubur-ubur dan organisme laut dalam lebih umum.',
        'Benar — banyak spesies ubur-ubur menunjukkan bioluminesensi.',
        'Ikan pari umumnya tidak bioluminesen.',
        'Kepiting biasanya tidak menghasilkan cahaya sendiri.',
      ],
    },
    {
      'question': 'Salah satu ancaman besar bagi terumbu karang adalah ...',
      'answers': [
        'Pemutihan karang (coral bleaching)',
        'Penangkapan ikan tradisional',
        'Pasang surut',
        'Gelombang kecil'
      ],
      'correctAnswer': 0,
      'explanations': [
        'Benar — pemutihan karang terkait peningkatan suhu laut dan mengancam kelangsungan terumbu.',
        'Penangkapan ikan dapat berdampak, tetapi pemutihan terkait iklim adalah ancaman utama.',
        'Pasang surut adalah fenomena alami, bukan ancaman utama.',
        'Gelombang kecil tidak setara ancaman luas seperti pemutihan.',
      ],
    },
    {
      'question': 'Organisme pengurai yang penting di dasar laut adalah ...',
      'answers': [
        'Detritivor seperti krustasea kecil',
        'Ikan paus',
        'Ubur-ubur',
        'Paus pembunuh'
      ],
      'correctAnswer': 0,
      'explanations': [
        'Benar — detritivor dan mikroba laut mendaur ulang materi organik menjadi nutrisi.',
        'Paus bukan pengurai utama.',
        'Ubur-ubur bukan pengurai utama.',
        'Paus pembunuh adalah predator, bukan pengurai.',
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
      timer?.cancel();
      Get.off(() => QuizResultPage(
            score: score,
            totalQuestions: questions.length,
            quizType: 'animal',
          ));
    }
  }

  Color getAnswerColor(int index) {
    if (!isAnswered) return Colors.transparent;

    if (index == questions[currentQuestionIndex]['correctAnswer']) {
      return Colors.green;
    }

    if (index == selectedAnswerIndex) return Colors.red;

    return Colors.transparent;
  }

  Color getAnswerBorderColor(int index) {
    if (!isAnswered) return Colors.white;

    if (index == questions[currentQuestionIndex]['correctAnswer']) {
      return Colors.green;
    }

    if (index == selectedAnswerIndex) return Colors.red;

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
              Positioned.fill(
                child: OceanBackgroundDecoration(
                  showWaves: true,
                  showBubbles: true,
                  showCreatures: true,
                  color: Colors.white,
                ),
              ),
              Column(
                children: [
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
