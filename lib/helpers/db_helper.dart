import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  var tableName = 'notes'; // Name of the table
  var columnId = 'note_id'; // Name of the ID column
  var columnDateTime = 'note_date_time'; // Name of the date-time column
  var columnContent = 'note_content'; // Name of the content column

  // Function to open the database
  Future<Database> openDB() async {
    var directory = await getApplicationDocumentsDirectory(); // Get the application documents directory
    await directory.create(recursive: true); // Create the directory if it doesn't exist

    var path = directory.path + 'notes_db.db'; // Path to the database file
    return await openDatabase(
      path, // Path to the database
      version: 1, // Version of the database
      onCreate: (db, version) { // Function to create the table if it doesn't exist
        db.execute(
            "create table $tableName ($columnId integer primary key autoincrement, $columnDateTime text, $columnContent text)");
      },
    );
  }

  // Function to add a new note
  Future<int> addData(String dateTime, String content) async {
    var myDB = await openDB(); // Open the database

    return myDB
        .insert(tableName, {columnDateTime: dateTime, columnContent: content}); // Insert the new note into the table
  }

  // Function to fetch all notes
  Future<List<Map<String, dynamic>>> fetchData() async {
    var myDB = await openDB(); // Open the database
    return myDB.query(tableName); // Query the table and return the result
  }

  // Function to update an existing note
  void updateData(int index, String dateTime, String content) async {
    var myDB = await openDB(); // Open the database
    myDB.update(tableName, {columnDateTime: dateTime, columnContent: content},
        where: "$columnId=?", whereArgs: ['$index']); // Update the note with the given ID
  }

  // Function to delete a note
  void deleteData(int index) async {
    var myDB = await openDB(); // Open the database
    myDB.delete(tableName, where: "$columnId=?", whereArgs: ['$index']); // Delete the note with the given ID
  }
}
