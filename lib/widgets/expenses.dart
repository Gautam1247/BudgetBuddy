import 'package:budgetbuddy/widgets/chart/chart.dart';
import 'package:budgetbuddy/widgets/expense_list/expenseslist.dart';
import 'package:budgetbuddy/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:budgetbuddy/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  void _addexpense(Expense expense) {
    setState(() {
      _requiredexpenses.add(expense);
    });
  }

  void _removeexpense(Expense expense) {
    int index = _requiredexpenses.indexOf(expense);
    setState(() {
      _requiredexpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Expense Deleted"),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _requiredexpenses.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  final List<Expense> _requiredexpenses = [
    Expense(
      amount: 19.09,
      category: Category.work,
      date: DateTime.now(),
      title: "Flutter Course",
    ),
    Expense(
      amount: 29,
      category: Category.leisure,
      date: DateTime.now(),
      title: "Cinema",
    ),
  ];
  void _getmodalsheetoverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpense(onaddexpense: _addexpense);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final wdt = MediaQuery.of(context).size.width;
    Widget maintext = Center(child: Text("NO EXPENSES ADDED"));
    if (_requiredexpenses.isNotEmpty) {
      maintext = Expenselist(
        expenses: _requiredexpenses,
        ondismissed: _removeexpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Expense Tracker App"),
        actions: [
          IconButton(onPressed: _getmodalsheetoverlay, icon: Icon(Icons.add)),
        ],
      ),
      body: wdt < 600
          ? Column(
              children: [
                Chart(expenses: _requiredexpenses),
                Expanded(child: maintext),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _requiredexpenses)),
                Expanded(child: maintext),
              ],
            ),
    );
  }
}
