import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:budgetbuddy/models/expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onaddexpense});
  final void Function(Expense expense) onaddexpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  @override
  void dispose() {
    _titlecontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  DateTime? selectedate;
  void datepicker() async {
    final now = DateTime.now();
    final init = DateTime(now.year - 1, now.month, now.day);
    final last = DateTime.now();
    final pickedate = await showDatePicker(
      context: context,
      firstDate: init,
      lastDate: last,
    );
    setState(() {
      selectedate = pickedate;
    });
  }

  void dialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) {
          return CupertinoAlertDialog(
            title: Text("Invalid Input", style: TextStyle(color: Colors.black)),
            content: Text(
              "Please Enter Valid Title, Date and Amount in their respective fields",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text("Okay"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Invalid Input", style: TextStyle(color: Colors.black)),
          content: Text(
            "Please Enter Valid Title, Date and Amount in their respective fields",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text("Okay"),
            ),
          ],
        ),
      );
    }
  }

  Category _selectedvalue = Category.leisure;
  void _saveexpense() {
    final titlename = _titlecontroller.text.trim();
    final amount = double.tryParse(_amountcontroller.text);
    final boolval = amount == null || amount <= 0;
    if (titlename.isEmpty || boolval || selectedate == null) {
      dialog();
    }
    widget.onaddexpense(
      Expense(
        amount: amount!,
        category: _selectedvalue,
        date: selectedate!,
        title: _titlecontroller.text,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, keyboard + 16),
          child: Column(
            children: [
              TextField(
                controller: _titlecontroller,
                style: Theme.of(context).textTheme.titleLarge,
                maxLength: 20,
                decoration: InputDecoration(label: Text("Title")),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountcontroller,
                      style: Theme.of(context).textTheme.titleLarge,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text("Amount"),
                        prefixText: 'Rs ',
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          selectedate == null
                              ? "Select Date"
                              : formatter.format(selectedate!),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        IconButton(
                          onPressed: datepicker,
                          icon: Icon(Icons.calendar_month),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  DropdownButton(
                    value: _selectedvalue,
                    items: Category.values
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Text(
                              value.name.toUpperCase(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _selectedvalue = value;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      return Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _saveexpense,
                    child: Text("Save Expense"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
