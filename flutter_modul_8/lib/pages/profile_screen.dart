import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_modul_8/pages/home_page.dart';
import 'package:flutter_modul_8/pages/login_page.dart';
import 'package:flutter_modul_8/pages/quiz_page.dart';
import '../widgets/custom_navbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = '';

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() => _name = prefs.getString('user_name') ?? '');
    } catch (_) {}
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF1A0088),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white24, width: 1.5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.logout_rounded,
                  color: Colors.white,
                  size: 48,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Are you sure you want to logout?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade700,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "No",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.offAll(() => const LoginPage());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF4757),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Yes",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF1A0088),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white24, width: 1.5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.delete_forever_rounded,
                  color: Color(0xFFFF4757),
                  size: 48,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Delete Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Are you sure you want to delete your account?\nThis action cannot be undone.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade700,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "No",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.offAll(() => const LoginPage());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF4757),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Yes",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final currentCtrl = TextEditingController();
    final newCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool obscureCurrent = true;
        bool obscureNew = true;
        bool obscureConfirm = true;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A0088),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Change Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: currentCtrl,
                      obscureText: obscureCurrent,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Current password',
                        hintStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white10,
                        suffixIcon: IconButton(
                          onPressed: () => setDialogState(
                              () => obscureCurrent = !obscureCurrent),
                          icon: Icon(
                            obscureCurrent
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white70,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: newCtrl,
                      obscureText: obscureNew,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'New password',
                        hintStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white10,
                        suffixIcon: IconButton(
                          onPressed: () =>
                              setDialogState(() => obscureNew = !obscureNew),
                          icon: Icon(
                            obscureNew
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white70,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: confirmCtrl,
                      obscureText: obscureConfirm,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Confirm new password',
                        hintStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white10,
                        suffixIcon: IconButton(
                          onPressed: () => setDialogState(
                              () => obscureConfirm = !obscureConfirm),
                          icon: Icon(
                            obscureConfirm
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white70,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Get.back(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade700,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final nw = newCtrl.text.trim();
                              final cf = confirmCtrl.text.trim();

                              if (nw.length < 6) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'New password must be at least 6 characters')),
                                );
                                return;
                              }
                              if (nw != cf) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Passwords do not match')),
                                );
                                return;
                              }

                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString('user_password', nw);

                              Get.back();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Password changed successfully')),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4F46E5),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Save',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0088),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Header dengan nama dan avatar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (_name.isNotEmpty)
                          Text(
                            _name,
                            style: TextStyle(
                              color:
                                  Colors.white.withAlpha((0.9 * 255).round()),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        else
                          Text(
                            "Manage your account",
                            style: TextStyle(
                              color:
                                  Colors.white.withAlpha((0.6 * 255).round()),
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white30, width: 2.5),
                      ),
                      child: const CircleAvatar(
                        radius: 32,
                        backgroundImage: AssetImage('assets/profile_pics.jpg'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Stats Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF120066),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        Icons.star_rounded,
                        const Color(0xFFFFD700),
                        "Points",
                        "2,450",
                      ),
                      _buildStatItem(
                        Icons.trending_up_rounded,
                        const Color(0xFF4F46E5),
                        "Streak",
                        "15",
                      ),
                      _buildStatItem(
                        Icons.check_circle_rounded,
                        const Color(0xFF10B981),
                        "Completed",
                        "0",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Settings Section
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Account Settings",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                _buildSettingButton(
                  context,
                  "Edit Profile",
                  () {
                    Get.to(() => const EditProfileScreen());
                  },
                ),
                const SizedBox(height: 16),

                _buildSettingButton(
                  context,
                  "Change Password",
                  () => _showChangePasswordDialog(context),
                ),
                const SizedBox(height: 16),

                // Danger Zone
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Danger Zone",
                    style: TextStyle(
                      color: Color(0xFFFF4757),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                _buildSettingButton(
                  context,
                  "Log Out",
                  () => _showLogoutConfirmation(context),
                ),
                const SizedBox(height: 16),

                _buildSettingButton(
                  context,
                  "Delete Account",
                  () => _showDeleteConfirmation(context),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Get.off(() => const HomePage());
          } else if (index == 1) {
            Get.off(() => const QuizListPage());
          }
        },
      ),
    );
  }

  Widget _buildStatItem(
      IconData icon, Color color, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingButton(
      BuildContext context, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF120066),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: text == "Delete Account"
                ? const Color(0xFFFF4757)
                : Colors.white12,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: text == "Delete Account"
                      ? const Color(0xFFFF4757)
                      : Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_rounded,
                color: text == "Delete Account"
                    ? const Color(0xFFFF4757)
                    : Colors.white,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _email = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final name = prefs.getString('user_name') ?? '';
      final email = prefs.getString('user_email') ?? '';
      final pass = prefs.getString('user_password') ?? '';
      setState(() {
        _nameController.text = name;
        _email = email;
        _password = pass;
      });
    } catch (_) {}
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFF0D004D),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Change Profile Photo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blueAccent),
              title: const Text('Take a Photo',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.photo_library, color: Colors.blueAccent),
              title: const Text('Choose from Gallery',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.back();
              },
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel',
                  style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0088),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white30,
                    child: const CircleAvatar(
                      radius: 56,
                      backgroundImage: AssetImage('assets/profile_pics.jpg'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showImageSourceActionSheet(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt,
                          color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _buildTextField("Full Name", _nameController),
              const SizedBox(height: 40),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Account Information',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF120066),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _buildInfoRow(
                        "Email", _email.isNotEmpty ? _email : 'Not set'),
                    const Divider(color: Colors.white12),
                    _buildInfoRow("Joined", "Feb 08, 2026"),
                    const Divider(color: Colors.white12),
                    _buildInfoRow(
                        "Password",
                        _password.isNotEmpty
                            ? List.filled(_password.length, '*').join()
                            : 'Not set'),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString(
                        'user_name', _nameController.text.trim());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Profile Updated Successfully!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF120066),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(color: Colors.white60, fontSize: 14)),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
