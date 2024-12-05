import 'package:flutter/widgets.dart';
import 'package:insta_clone/auth/auth_methods.dart';
import 'package:insta_clone/classes/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    print('testttt');
    User user = await _authMethods.getUserDetails();
    print("im fuckss");
    _user = user;
    notifyListeners();
  }
}
