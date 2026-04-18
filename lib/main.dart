import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:wisdom_gre_app/features/dashboard/presentation/screens/dashboard_screen.dart';

void main() {
  FlutterForegroundTask.initCommunicationPort();
  runApp(const ProviderScope(child: WisdomGreApp()));
}

class WisdomGreApp extends StatelessWidget {
  const WisdomGreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Premium GRE Vocabulary',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Inter', // Assuming standard modern sans, could be custom
      ),
      home: const DashboardScreen(),
    );
  }
}
