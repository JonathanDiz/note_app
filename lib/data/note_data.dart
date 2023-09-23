import 'package:note_app/models/note_model.dart';

class NoteData {
  static List<Note> notes = [];

  static void addNote(Note note) {
    notes.add(note);
  }

  static void deleteNote(Note note) {
    notes.remove(note);
  }

  static List<Note> getNotes() {
    return notes;
  }
}