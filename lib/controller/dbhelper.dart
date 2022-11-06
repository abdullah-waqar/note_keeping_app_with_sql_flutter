import 'dart:io';

import 'package:lecture_14/linker.dart';

class DBHelper {
  // PRIVATE CONSTRUCTOR

  DBHelper._privateConstructor();

  // Instance of  Private Construtor

  static final instance = DBHelper._privateConstructor();

  // INSTANCE OF DATABASE

  Database? _database;

  // CHECKING DATABASE

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDatabase();
      return _database;
    }

    // if (_database != null) return _database;
    // _database = await _initDatabase();
    // return _database;
  }

  // INITILIZITION

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'Note.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) {
    db.execute('''
        Create Table Note(
          id integer primary key,
          title text not null,
          message text not null,
          date text not null
        )
      ''');
  }

  // CRUD FUNCTIONS

  // CREATE

  create(Note note) async {
    // Convert into json format (we will add the data into json format)

    Map<String, dynamic> notejson = {
      'title': note.title,
      'message': note.message,
      'date': note.date
    };
    print(notejson.toString());
    var db = await instance.database;
    int? id = await db?.insert('Note', notejson);

    print("Insert data with id $id");
    // if (id == null) {
    //   print("Data did not saved");
    // } else {
    //   print("Insert data with id $id");
    // }
  }

  // READ

  read() async {
    var db = await instance.database;
    return db?.query('Note');
  }

  // UPDATE

  // To update(First we will take the note(Data that has to be change) and the unique id)
  update(Note note, int id) async {
    Map<String, dynamic> notejson = {
      'title': note.title,
      'message': note.message,
      'date': note.date,
    };

    var db = await instance.database;

    db?.update('Note', notejson, where: 'id=?', whereArgs: [id]);
  }

  // DELETE

  delete(int id) async {
    var db = await instance.database;
    db?.delete('Note', where: 'id=?', whereArgs: [id]);
  }

// It Will Clear everythin
  deleteAll() async {
    var db = await instance.database;
    db?.delete("Note");
  }
}
