import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../services/app_state.dart';
import '../home/home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  bool loading = false;

  Future<void> submit() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    setState(() {
      loading = true;
    });

    final success = await AppState.instance.login(
      email,
      password,
    );

    if (!mounted) return;

    setState(() {
      loading = false;
    });

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Email harus diisi dan password minimal 4 karakter.',
          ),
        ),
      );

      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const HomePage(),
      ),
      (_) => false,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            24,
            55,
            24,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.school_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                'Selamat datang kembali!',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.text,
                ),
              ),

              const SizedBox(height: 7),

              const Text(
                'Masuk untuk melanjutkan perjalanan belajar TIK kamu.',
                style: TextStyle(
                  color: AppTheme.muted,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'EMAIL ATAU USERNAME',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.muted,
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.mail_outline_rounded,
                  ),
                  hintText: 'nama@email.com',
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                'PASSWORD',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.muted,
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                  ),
                  hintText: 'Masukkan password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Lupa Password?',
                  ),
                ),
              ),

              const SizedBox(height: 8),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: loading ? null : submit,
                  child: loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Masuk',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 14),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RegisterPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Daftar Akun Baru',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}