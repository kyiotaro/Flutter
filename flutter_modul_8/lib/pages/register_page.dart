import 'package:flutter/material.dart';
import 'package:flutter_modul_8/pages/home_page.dart';
import '../../widgets/input_field.dart';
import '../../widgets/primary_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Color(0xFF2A0A6E),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Image.asset('assets/logo.png', height: 120),
                const SizedBox(height: 24),
                const Text(
                  "Bergabung dengan kami!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                inputField("Masukkan Email anda..."),
                const SizedBox(height: 16),
                inputField("Masukkan Username anda..."),
                const SizedBox(height: 16),
                inputField("Buat Sandi yang kuat...", obscure: true),
                const SizedBox(height: 16),
                inputField("Ulangi Sandi anda...", obscure: true),
                const SizedBox(height: 24),

                // Checkbox dengan teks
                Row(
                  children: [
                    Checkbox(
                      value: _isAgreed,
                      onChanged: (value) {
                        setState(() {
                          _isAgreed = value ?? false;
                        });
                      },
                      activeColor: const Color(0xFF2A0A6E),
                      checkColor: Colors.white,
                    ),
                    const Expanded(
                      child: Text(
                        "Saya setuju dengan syarat dan ketentuan",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Tombol muncul hanya jika checkbox dicentang
                if (_isAgreed)
                  primaryButton("Daftar", () {
                    Get.to(() => const HomePage());
                  }),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Text(
                    "Sudah punya akun? Masuk",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
