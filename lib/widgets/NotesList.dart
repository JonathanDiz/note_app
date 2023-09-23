import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';

class NotesList extends StatelessWidget {
  final List<Note> notes;

  const NotesList({Key? key, required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(note.title),
            subtitle: Text(note.title),
            trailing: Text(note.date.toString()), // Puedes formatear la fecha según tus poreferencias
          ),
        );
      },
    );
  }
}