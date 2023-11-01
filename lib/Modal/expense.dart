import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();
final dateformater = DateFormat.yMd();

enum Categories { work, leisure, shopping, travel, food }

Map iconcategory = {
  Categories.work: Icons.work,
  Categories.shopping: Icons.trolley,
  Categories.food: Icons.dinner_dining,
  Categories.travel: Icons.location_on,
  Categories.leisure: Icons.abc
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : uid = uuid.v4();

  final String title;
  final double amount;
  final DateTime date;
  final String uid;
  final Categories category;

  String get formateddate {
    return dateformater.format(date);
  }
}
