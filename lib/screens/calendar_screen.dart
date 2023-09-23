import 'package:flutter/material.dart';
import 'package:note_app/providers/note_provider.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/widgets/calendar_widget.dart';
import 'package:note_app/widgets/NotesList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
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
  late Future<List<Note>?> _notesFuture;
  TextEditingController titleController = TextEditingController(); // Controlador para el título de la nota
  TextEditingController contentController = TextEditingController(); // Controlador para el contenido de la nota
  List<Note> savedNotes = []; // Lista para almacenar las notas guardadas

  @override
  void initState() {
    super.initState();
    _notesFuture = _fetchNotes();
  }

  Future<List<Note>?> _fetchNotes() async {
    try {
      return NoteProvider().getNotes();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al cargar las notas: $error'),
        duration: const Duration(seconds: 5),
      ));
      return null; // Devolver null en caso de error
    }
  }

  void _saveNote() {
    // Obtiene el título y el contenido de los controladores
    final String title = titleController.text;
    final String content = contentController.text;

    if (title.isNotEmpty && content.isNotEmpty) {
      // Crea una nueva nota y agrégala a la lista de notas guardadas
      final note = Note(
        title: title,
        date: DateTime.now(),
        content: content,
      );
      setState(() {
        savedNotes.add(note);
      });

      // Limpia los controladores
      titleController.clear();
      contentController.clear();
    }
  }

  Widget _buildBody() {
    return FutureBuilder<List<Note>?>(
      future: _notesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No se pueden cargar las notas en este momento. Inténtelo de nuevo más tarde.'),
          );
        } else {
          final notes = snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: CalendarWidget(notes: notes),
              ),
              Expanded(
                child: NotesList(notes: savedNotes), // Usar savedNotes para mostrar las notas guardadas
              ),
            ],
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes Calendar'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Muestra un diálogo para agregar una nota
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Agregar una nota'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Título de la nota'),
                    ),
                    TextField(
                      controller: contentController,
                      decoration: const InputDecoration(labelText: 'Contenido de la nota'),
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Cierra el diálogo
                    },
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Guardar la nota
                      _saveNote();
                      Navigator.of(context).pop(); // Cierra el diálogo
                    },
                    child: const Text('Guardar'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
