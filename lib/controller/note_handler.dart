import 'package:lecture_14/controller/dbhelper.dart';
import 'package:lecture_14/linker.dart';

addNote(String title, String message, String time) async {
  Note note = Note();

  note.title = title;
  note.message = message;
  note.date = time;
  DBHelper db = DBHelper.instance;
  print(note.toString());
  await db.create(note);

  Get.to(HomeView());
}

deleteNote(int id) {
  DBHelper db = DBHelper.instance;
  db.delete(id);
  Get.snackbar("Note", "Note Deleted");
}


