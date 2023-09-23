import 'package:flutter/material.dart';
import 'package:note_app/providers/note_provider.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/widgets/calendar_widget.dart';

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
      home: const CalendarScreen(),
    );
  }
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late Future<List<Note>> _notesFuture;

  @override
  void initState() {
    super.initState();
    _notesFuture = _fetchNotes();
  }

  Future<List<Note>> _fetchNotes() async {
    try {
      return NoteProvider().getNotes();
    } catch (error) {
      // Manejo de errores: muestra un mensaje emergente (SnackBar) en caso de error.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al cargar las notas: $error'),
        duration: const Duration(seconds: 5),
      ));
      return <Note>[];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes Calendar'),
      ),
      body: FutureBuilder<List<Note>>(
        future: _notesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No se pueden cargar las notas en este momento. Inténtelo de nuevo más tarde.'),
            );
          } else {
            final notes = snapshot.data;
            return CalendarWidget(notes: notes);
          }
        },
      ),
    );
  }
}
