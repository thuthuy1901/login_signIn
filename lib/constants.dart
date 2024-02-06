import 'package:flutter/material.dart';

const String nameApp = "Book";
const String urlUser = "http://10.10.73.169:3000/users";

enum colorApp {
  Background(Colors.black),
  Primary(Colors.black26),
  Second(Colors.blueGrey),
  Text(Colors.white),
  Notice(Colors.red),
  Work(Colors.blue);

  const colorApp(this.color);
  final Color color;
}

String? checkEmpty(String? data) {
  if (data == null || data.isEmpty) {
    return "empty";
  }
  return null;
}
