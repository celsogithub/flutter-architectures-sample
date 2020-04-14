import 'dart:ui';
import 'package:flutter/material.dart';

class Category {

  String name;
  Color color;

  Category({
    this.name,
    this.color
  });

  static Color colorByName(String name) {
    switch(name) {
      case "Personal":
        return Colors.redAccent;
      case "Work":
        return Colors.greenAccent;
      case "Family":
        return Colors.blueAccent;
      case "Friends":
        return Colors.yellowAccent;
      default:
        return Colors.deepPurpleAccent;
    }
  }
}