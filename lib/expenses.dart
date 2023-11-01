import 'package:expense_tracker/Modal/expense.dart';
import 'package:expense_tracker/add_item.dart';
import 'package:expense_tracker/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Expenses extends StatefulWidget {
  const Expenses({
    super.key,
  });
  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<Expense> declaredExpenses = [
    Expense(
        title: "Laptop",
        amount: 80000,
        date: DateTime.now(),
        category: Categories.work),
    Expense(
        title: "Clothing",
        amount: 4500,
        date: DateTime.now(),
        category: Categories.shopping)
  ];
  void showAddItemOverlay() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Additem(
            getcreateItem: addItem,
          );
        });
  }

  void addItem(Expense expenses) {
    setState(() {
      declaredExpenses.add(expenses);
    });
  }

  void removeitem(int index) {
    late Expense temp;
    setState(() {
      temp = declaredExpenses.removeAt(index);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Item is removed successfully."),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              declaredExpenses.insert(index, temp);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Expense Tracker App",
          style: GoogleFonts.inter(fontSize: 20),
        )),
        actions: [
          IconButton(
              onPressed: () {
                showAddItemOverlay();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(children: [
        const Text(
          "Expenses",
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
            child: ExpenseList(
          expenses: declaredExpenses,
          removeitem: removeitem,
        )),
      ]),
    );
  }
}
