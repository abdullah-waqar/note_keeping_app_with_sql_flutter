import 'package:lecture_14/controller/dbhelper.dart';
import 'package:lecture_14/controller/note_handler.dart';
import 'package:lecture_14/linker.dart';

class AddNoteView extends StatefulWidget {
  const AddNoteView({super.key});

  @override
  State<AddNoteView> createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  String? time;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  child: Center(
                    child: Text(
                      'ADD NOTE',
                      style: GoogleFonts.roboto(
                          fontSize: 24,
                          color: Colors.teal,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orangeAccent),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: 'Enter title',
                      prefixIcon: Icon(
                        Icons.bookmark_add_rounded,
                        color: Colors.orange,
                      ),
                      hintStyle: TextStyle(color: Colors.orange, fontSize: 18),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orangeAccent),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Enter title',
                      prefixIcon: Icon(
                        Icons.bookmark_add_rounded,
                        color: Colors.orange,
                      ),
                      hintStyle: TextStyle(color: Colors.orange, fontSize: 18),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    TimeOfDay currentTime = TimeOfDay.now();
                    time = '${currentTime.hour} : ${currentTime.minute}';
                    String title = titleController.text;
                    String message = messageController.text;
                    print("Title: $title");
                    print("Message: $message");
                    print("time: $time");
                    
                    await addNote(title, message, time!);
                    
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: isLoading == true
                      ? const CircularProgressIndicator()
                      : Container(
                          height: 50,
                          width: 100,
                          color: Colors.orangeAccent,
                          child: const Center(
                            child: Text("Add Note"),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
