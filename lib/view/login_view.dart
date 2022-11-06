import 'package:lecture_14/linker.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login View"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Login Screen",
            style: TextStyle(
                color: Color.fromARGB(255, 5, 78, 71),
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            color: Colors.amber,
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                hintText: "Enter User Name",
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              String name = nameController.text;
              setName(name);
            },
            child: Container(
              height: 50,
              width: 100,
              color: Colors.amber,
              child: const Center(
                child: Text("Join"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
