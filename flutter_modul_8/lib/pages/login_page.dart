import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/input_field.dart';
import '../../widgets/primary_button.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();

  Future<void> _saveCredentialsAndLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', _emailCtrl.text.trim());
    await prefs.setString('user_password', _passCtrl.text);
    Get.offAll(() => const HomePage());
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
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
                  "Selamat datang kembali!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Siap untuk menjelajahi lautan ilmu?",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 30),
                inputField("Masukkan Email anda...", controller: _emailCtrl),
                const SizedBox(height: 16),
                inputField("Masukkan Sandi Anda...",
                    obscure: true, controller: _passCtrl),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      "Lupa sandi/email?",
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.white.withAlpha((0.3 * 255).round()),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Atau masuk dengan",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.white.withAlpha((0.3 * 255).round()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildSocialButton(
                        label: 'Google',
                        child: Image.asset('assets/google_icon.png',
                            width: 20, height: 20),
                        iconColor: Colors.red,
                        onPressed: () {
                          Get.offAll(() => const HomePage());
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSocialButton(
                        label: 'Facebook',
                        icon: Icons.facebook,
                        iconColor: const Color(0xFF1877F2),
                        onPressed: () {
                          Get.offAll(() => const HomePage());
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Tidak memiliki akun? ",
                      style: TextStyle(color: Colors.white70),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const RegisterPage());
                      },
                      child: const Text(
                        "Daftar",
                        style: TextStyle(
                          color: Color(0xFF3B82F6),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const Text(
                      " disini",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                primaryButton("Masuk", () => _saveCredentialsAndLogin()),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String label,
    IconData? icon,
    Widget? child,
    required Color iconColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child ??
              Icon(
                icon,
                size: 24,
                color: iconColor,
              ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

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
