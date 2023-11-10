// ignore_for_file: unused_field, unused_import

import 'package:flutter/foundation.dart';
import 'package:laporbos/model/attendance.dart';

import 'package:laporbos/model/user.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  get attendance => null;

  void setUser(UserModel? user) {
    _user = user;
    notifyListeners();
  }
}
