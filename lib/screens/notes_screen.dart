import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/widgets/note_list.dart'; // Importa el widget correcto
import 'package:note_app/widgets/add_note_widget.dart';
import 'package:note_app/providers/note_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NoteScreen(),
    );
  }
}

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late Future<List<Note>?> _notesFuture;

  @override
  void initState() {
    super.initState();
    _notesFuture = _fetchNotes();
  }

  Future<List<Note>?> _fetchNotes() async {
    try {
      // Lógica para cargar notas desde el proveedor
      final notes = await NoteProvider().getNotes();
      return notes;
    } catch (error) {
      // Manejar el error (puedes mostrar un mensaje de error si es necesario)
      return <Note>[]; // Devuelve una lista vacía en caso de error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes Calendar'),
      ),
      body: _buildBody(),
    );
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
                child: NotesList(notes: notes), // Utiliza el widget NotesList
              ),
              const Expanded(
                child: AddNoteWidget(),
              ),
            ],
          );
        }
      },
    );
  }
}
