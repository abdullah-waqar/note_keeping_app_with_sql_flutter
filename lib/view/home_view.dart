import 'package:lecture_14/controller/dbhelper.dart';
import 'package:lecture_14/controller/note_handler.dart';
import 'package:lecture_14/linker.dart';
import 'package:lecture_14/view/form_view.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

List noteList = [];
List reversedList = [];

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    getNoteList();
    super.initState();
  }

  getNoteList() async {
    DBHelper db = DBHelper.instance;

    noteList = await db.read();
    reversedList = noteList.reversed.toList();
    setState(() {});
    print(reversedList);
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Notes"),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(AddNoteView());
                },
                icon: const Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  logout();
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: ListView.builder(
            itemCount: reversedList.length,
            itemBuilder: (context, index) {
              return noteCard(
                reversedList[index]['title'],
                reversedList[index]['message'],
                reversedList[index]['date'],
                reversedList[index]['id'],
                index,
                context,
              );
            }),
      ),
    );
  }

  noteCard(String title, String message, String date, int id, int index,
      BuildContext context) {
    return InkWell(
      onLongPress: () {
        deleteNote(id);
        getNoteList();
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 100,
        decoration: BoxDecoration(
            color: Colors.orangeAccent, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey,
              child: Text(id.toString()),
            ),
            title: Text(title),
            subtitle: Text(message),
            trailing: IconButton(
                onPressed: () {
                  editNote(
                    reversedList[index]['title'],
                    reversedList[index]['message'],
                    reversedList[index]['id'],
                  );
                },
                icon: const Icon(Icons.edit)),
          ),
        ),
      ),
    );
  }

  editNote(String title, String message, int id) {
    return Get.defaultDialog(
      title: "Edit Note",
      content: Column(
        children: [
          Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: titleController..text = title,
                  decoration: const InputDecoration(),
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: messageController..text = message,
                decoration: const InputDecoration(
                  hintText: "Enter the message",
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                editDone(titleController.text, messageController.text, id);
              },
              child: const Text("OK"))
        ],
      ),
    );
  }

  editDone(String title, String message, int id) async {
    var db = await DBHelper.instance;
    Note note = Note();
    note.title = title;
    note.message = message;
    note.date = '';
    db.update(note, id);
    getNoteList();
    Get.back();
  }
}
