

import 'package:flutter/material.dart';

class SupabaseProvider extends ChangeNotifier {
 late int userId;
 int get getUserId => userId;

  void setUserId(int uId) {
    userId = uId;
    notifyListeners();
  }
}