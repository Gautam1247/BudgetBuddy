import 'package:budgetbuddy/models/expense.dart';
import 'package:budgetbuddy/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Expenselist extends StatelessWidget {
  const Expenselist({
    super.key,
    required this.expenses,
    required this.ondismissed,
  });
  final List<Expense> expenses;
  final void Function(Expense expense) ondismissed;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error,
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        onDismissed: (direction) {
          ondismissed(expenses[index]);
        },
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
