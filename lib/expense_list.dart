import 'package:expense_tracker/Modal/expense.dart';
import 'package:expense_tracker/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenses, required this.removeitem});
  final List<Expense> expenses;
  final Function(int index) removeitem;

  @override
  Widget build(BuildContext context) {
    Widget maincontent = const Center(child: Text("Add Expense"));
    if (expenses.isNotEmpty) {
      maincontent = ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (context, index) {
            return Dismissible(
                key: ValueKey(expenses[index]),
                onDismissed: (direction) => removeitem(index),
                child: ExpenseItem(expense: expenses[index]));
          });
    }

    return maincontent;
  }
}
