import 'package:lecture_14/linker.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}
  

class _SplashViewState extends State<SplashView> {
  @override
  void initState()  {
     whereMove();
    super.initState();
  }

  whereMove() async {
    bool isLogin = await authenticate();
    if (isLogin == true) {
      Timer(const Duration(seconds: 2), () => Get.to(const HomeView()));
    } else {
      Timer(const Duration(seconds: 2), () => Get.to(LoginView()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              backgroundColor: Colors.teal,
              radius: 50,
              child: Center(
                child: Text(
                  "NOTE",
                  style: TextStyle(color: Colors.tealAccent),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "NOTE KEEPER",
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}
