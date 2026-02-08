import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/time_entry_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TimeEntryProvider(),
      child: const TimeTrackingApp(),
    ),
  );
}

class TimeTrackingApp extends StatelessWidget {
  const TimeTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4A9084),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4A9084),
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFFD54F),
          foregroundColor: Colors.black,
        ),
        cardTheme: const CardThemeData(
           elevation: 3,
           margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
           shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.all(Radius.circular(12)),
           ),
         ),
        ),
           home: const HomeScreen(),
           );
         }
      }