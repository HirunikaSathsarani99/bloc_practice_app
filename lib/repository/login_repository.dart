import 'package:test_app/model/user_model.dart';

class LoginRepository {
  User user = User(name: "abc@gmail.com", password: "123456");

  Future<bool> login(String userName, String Password) async {
    // await Future.delayed(Duration(seconds: 2));

    if (user.name == userName && user.password == Password) {
      print(user.name );
      return true;
    } 
    else {
      return false;
    }
  }
}
