import 'package:expense_tracker/Modal/expense.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  const ExpenseItem({super.key, required this.expense});
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Text(
            expense.title,
            style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
          ),
          Row(
            children: [
              Text('\$${expense.amount}'),
              const Spacer(),
              Icon(iconcategory[expense.category]),
              const SizedBox(
                width: 10,
              ),
              Text(expense.formateddate),
            ],
          )
        ],
      ),
    ));
  }
}
