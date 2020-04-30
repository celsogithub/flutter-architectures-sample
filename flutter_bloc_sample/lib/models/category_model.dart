import 'dart:ui';
import 'package:flutter/material.dart';

enum CategoryType {
  PERSONAL,
  WORK,
  FAMILY,
  FRIENDS,
  ALL
}

class Category {

  CategoryType type;
  Color color;

  Category({
    this.type,
    this.color
  });

  static Color colorByName(CategoryType type) {
    switch(type) {
      case CategoryType.PERSONAL:
        return Colors.redAccent;
      case CategoryType.WORK:
        return Colors.greenAccent;
      case CategoryType.FAMILY:
        return Colors.blueAccent;
      case CategoryType.FRIENDS:
        return Colors.yellowAccent;
      default:
        return Colors.deepPurpleAccent;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Category &&
              runtimeType == other.runtimeType &&
              type == other.type &&
              color == other.color;

  @override
  int get hashCode =>
      type.hashCode ^
      color.hashCode;
}