import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];
  bool _isLoading = false;

  List<Note> get notes => _notes;
  bool get isLoading => _isLoading;

  NoteProvider() {
    loadNotes();
  }

  Future<void> loadNotes() async {
    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? notesJson = prefs.getString('notes');

      if (notesJson != null) {
        List<dynamic> notesList = json.decode(notesJson);
        _notes = notesList.map((noteJson) => Note.fromJson(noteJson)).toList();
      }
    } catch (e) {
      print('Error loading notes: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveNotes() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> notesJson = _notes
          .map((note) => note.toJson())
          .toList();
      await prefs.setString('notes', json.encode(notesJson));
    } catch (e) {
      print('Error saving notes: $e');
    }
  }

  void addNote(Note note) {
    _notes.insert(0, note);
    saveNotes();
    notifyListeners();
  }

  void updateNote(Note updatedNote) {
    int index = _notes.indexWhere((note) => note.id == updatedNote.id);
    if (index != -1) {
      _notes[index] = updatedNote;
      saveNotes();
      notifyListeners();
    }
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    saveNotes();
    notifyListeners();
  }

  Future<void> refreshNotes() async {
    await Future.delayed(Duration(milliseconds: 500));
    await loadNotes();
  }
}
