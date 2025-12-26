import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryicons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.amount,
    required this.category,
    required this.date,
    required this.title,
  }) : id = uuid.v4();
  final String id;
  final double amount;
  final DateTime date;
  final Category category;
  final String title;

  String get formatted {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket(this.category, this.expenses);
  final Category category;
  final List<Expense> expenses;
  ExpenseBucket.forCategory(List<Expense> allexpenses, this.category)
    : expenses = allexpenses
          .where((expense) => expense.category == category)
          .toList();
  double get totalExpenses {
    double sum = 0;
    for (var expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
