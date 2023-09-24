import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';

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

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes Calendar'),
      ),
      body: const AddNoteWidget(),
    );
  }
}

class AddNoteWidget extends StatefulWidget {
  const AddNoteWidget({Key? key}) : super(key: key);

  @override
  _AddNoteWidget createState() => _AddNoteWidget();
}

class _AddNoteWidget extends State<AddNoteWidget> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final List<Note> savedNotes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes Calendar'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Guardar la nota
                      _saveNote();
                      Navigator.of(context).pop();
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

  void _saveNote() {
    final String title = titleController.text;
    final String content = contentController.text;

    if (title.isNotEmpty && content.isNotEmpty) {
      final note = Note(
        title: title,
        date: DateTime.now(),
        content: content,
      );

      setState(() {
        savedNotes.add(note); // Agregar la nota a la lista de notas guardadas
      });

      titleController.clear();
      contentController.clear();
    }
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Aquí se mostrarán las notas guardadas.',
            style: TextStyle(fontSize: 18.0),
          ),
          if (savedNotes.isNotEmpty)
            for (var note in savedNotes)
              Card(
                margin: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text(note.title), // Usar la variable 'note'
                  subtitle: Text(note.content), // Usar la variable 'note'
                  trailing: Text(note.date.toString()), // Usar la variable 'note'
                ),
              ),
        ],
      ),
    );
  }
}
