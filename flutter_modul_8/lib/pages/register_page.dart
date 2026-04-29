import 'package:flutter/material.dart';
import 'package:flutter_modul_8/pages/home_page.dart';
import '../../widgets/input_field.dart';
import '../../widgets/primary_button.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isAgreed = false;
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _userCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  final TextEditingController _confirmPassCtrl = TextEditingController();

  Future<void> _saveCredentialsAndRegister() async {
    if (_passCtrl.text != _confirmPassCtrl.text) {
      Get.snackbar(
        "Error",
        "Sandi tidak cocok",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', _emailCtrl.text.trim());
    await prefs.setString('user_name', _userCtrl.text.trim());
    await prefs.setString('user_password', _passCtrl.text);
    
    Get.offAll(() => const HomePage());
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _userCtrl.dispose();
    _passCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

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
                inputField("Masukkan Email anda...", controller: _emailCtrl),
                const SizedBox(height: 16),
                inputField("Masukkan Username anda...", controller: _userCtrl),
                const SizedBox(height: 16),
                inputField("Buat Sandi yang kuat...", obscure: true, controller: _passCtrl),
                const SizedBox(height: 16),
                inputField("Ulangi Sandi anda...", obscure: true, controller: _confirmPassCtrl),
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
                  primaryButton("Daftar", () => _saveCredentialsAndRegister()),
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
