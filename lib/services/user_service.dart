import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserService {
  Future<void> saveCurrentUser(User user) async {
    await SharedPreferences.getInstance().then((sp) async {
      await sp.setString("current_user_email", user.email);
      await sp.setString("current_user_name", user.fullName);
      print("User saved successfully");
    });
  }

  Future<User?> getCurrentUser() async {
    User u = User();
    await SharedPreferences.getInstance().then((sp) async {
      u.email = sp.getString("current_user_email")!;
      u.fullName = sp.getString("current_user_name")!;
      print("Success!!!");
    });
    return u;
  }

  Future<void> clearCurrentUser() async {
    await SharedPreferences.getInstance().then((sp) async {
      await sp.remove("current_user_email");
      await sp.remove("current_user_name");
      print("Local user data cleared");
    });
  }
}
