import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/pages/login_screen.dart';

void main() {
  runApp(const EthioExamAI());
}

class EthioExamAI extends StatelessWidget {
  const EthioExamAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ethio-Exam AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}
