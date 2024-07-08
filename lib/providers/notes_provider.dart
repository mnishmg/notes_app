import 'package:flutter/material.dart';

import '../helpers/db_helper.dart';

class NotesProvider extends ChangeNotifier {
  DBHelper dbHelper = DBHelper(); // Instance of DBHelper to interact with the database
  List<Map<String, dynamic>> arrData = []; // List to hold notes data

  // Method to add a new note to the database
  void addNote(String dateTime, String content) async {
    await dbHelper.addData(dateTime, content); // Adding data to the database
    arrData = await dbHelper.fetchData(); // Fetching updated data from the database
    notifyListeners();
  }

  // Method to fetch all notes from the database
  void fetchNotes() async {
    arrData = await dbHelper.fetchData(); // Fetching data from the database
    notifyListeners();
  }

  // Method to update an existing note in the database
  void updateNote(int columnId, String dateTime, String content) async {
    dbHelper.updateData(columnId, dateTime, content); // Updating data in the database
    arrData = await dbHelper.fetchData(); // Fetching updated data from the database
    notifyListeners();
  }

  // Method to delete a note from the database
  void deleteNote(int columnId) async {
    dbHelper.deleteData(columnId); // Deleting data from the database
    arrData = await dbHelper.fetchData(); // Fetching updated data from the database
    notifyListeners();
  }
}
