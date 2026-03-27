import 'package:flutter/material.dart';

enum StudentStream { natural, social }

class UserProvider extends ChangeNotifier {
  String _name = 'Betsinat Amare';
  int _grade = 12;
  StudentStream _stream = StudentStream.natural;

  String get name => _name;
  int get grade => _grade;
  StudentStream get stream => _stream;

  void updateProfile({String? name, int? grade, StudentStream? stream}) {
    if (name != null) _name = name;
    if (grade != null) _grade = grade;
    if (stream != null) _stream = stream;
    notifyListeners();
  }

  String get streamName => _stream == StudentStream.natural ? 'Natural' : 'Social';
}
