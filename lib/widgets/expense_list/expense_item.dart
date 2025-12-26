import 'package:flutter/material.dart';
import 'package:budgetbuddy/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title,style: Theme.of(context).textTheme.titleLarge,),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('Rs ${expense.amount.toStringAsFixed(2)}',style: Theme.of(context).textTheme.titleLarge),
                Spacer(),
                Row(
                  children: [
                    Icon(categoryicons[expense.category]),
                    Text(expense.formatted,style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
