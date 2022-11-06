import 'package:lecture_14/linker.dart';

authenticate() async {
  var pref = await SharedPreferences.getInstance();

  String? name = pref.getString('name');

  if (name == null) {
    return false;
  } else {
    return true;
  }
}

setName(String name) async {
  var pref = await SharedPreferences.getInstance();
  await pref.setString('name', name);
  print("Name : $name");
  Get.to(const HomeView());
}

logout() async {
  var pref = await SharedPreferences.getInstance();
  await pref.remove('name');
  Get.to(LoginView());
}
