import 'package:flutter/material.dart';
import 'package:note_app/screens/calendar_screen.dart'; // Importa el archivo que contiene CalendarScreen.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalendarScreen(), // Aquí utiliza CalendarScreen como página de inicio.
    );
  }
}
