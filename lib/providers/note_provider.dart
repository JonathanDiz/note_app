import 'package:note_app/models/note_model.dart';

class NoteProvider {
  // Supongamos que tienes una lista de notas como fuente de datos.
  final List<Note> _notes = [
    Note(title: 'Nota 1', content: 'Contenido de la nota 1', date: DateTime.now()),
    Note(title: 'Nota 2', content: 'Contenido de la nota 2', date: DateTime.now()),
    // Agrega más notas según sea necesario.
  ];

  List<Note> getNotes() {
    // En este ejemplo, simplemente devolvemos la lista de notas.
    return _notes;
  }
}
