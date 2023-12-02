import 'package:expense_tracker/utils/util_me.dart';
import 'package:flutter/material.dart';

enum Category { food, travel, work, leisure }

const categoryIcon = {
  Category.food: Icons.lunch_dining_rounded,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie_creation_rounded,
  Category.work: Icons.work,
};

class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  ExpenseModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate {
    return dateFormatter.format(date);
  }
}

final List<ExpenseModel> theExpenseList = [
  ExpenseModel(
    title: "Demo item 1",
    amount: 99,
    date: DateTime.now(),
    category: Category.leisure,
  ),
  ExpenseModel(
    title: "Demo item 2",
    amount: 49,
    date: DateTime.now(),
    category: Category.work,
  ),
];