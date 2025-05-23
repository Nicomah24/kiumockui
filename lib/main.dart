import 'package:flutter/material.dart';
import 'screens/dashboard_page.dart';
import 'screens/academics_page.dart';
import 'screens/login_screen.dart';
import 'screens/settings_page.dart';
import 'screens/support_page.dart';
import 'screens/finance_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Portal',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const SignInPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/academics': (context) => const AcademicsPage(),
        '/settings': (context) => const SettingsPage(),
        '/support': (context) => const SupportPage(),
        '/finance': (context) => const FinancePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
