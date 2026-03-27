import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/schedule_provider.dart';
import 'core/providers/user_provider.dart';
import 'features/auth/presentation/pages/login_screen.dart';
import 'shared/widgets/main_shell.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScheduleProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const EthioExamAI(),
    ),
  );
}

class EthioExamAI extends StatelessWidget {
  const EthioExamAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ethio-Exam AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/home': (_) => const MainShell(),
      },
    );
  }
}
