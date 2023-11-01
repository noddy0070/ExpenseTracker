import 'package:expense_tracker/Modal/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final dateformater = DateFormat.yMd();

class Additem extends StatefulWidget {
  const Additem({super.key, required this.getcreateItem});
  final Function(Expense expenses) getcreateItem;

  @override
  State<Additem> createState() => _AdditemState();
}

class _AdditemState extends State<Additem> {
  TextEditingController itemName = TextEditingController();
  TextEditingController expense = TextEditingController();
  DateTime date = DateTime.now();
  String? selectedDate;
  late DateTime chosendate;
  Categories selectedcategory = Categories.leisure;
  void _presentdatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month - 1, now.day - 1);
    final lastDate = now;

    DateTime? pickeddate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);
    setState(() {
      chosendate = pickeddate!;
      selectedDate = dateformater.format(pickeddate);
    });
  }

  void createitem() {
    final amount = double.tryParse(expense.text);
    final isAmountValid = amount == null || amount <= 0;
    if (itemName.text.trim().isEmpty || selectedDate == null || isAmountValid) {
      print("object");
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("Enter Valid Text"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Ok"))
              ],
            );
          });
      return;
    }
    widget.getcreateItem(Expense(
        title: itemName.text,
        amount: amount,
        date: chosendate,
        category: selectedcategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    expense.dispose();
    itemName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
                labelText: "Item name", labelStyle: TextStyle(fontSize: 16)),
            maxLength: 50,
            controller: itemName,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                      labelText: "Expense",
                      labelStyle: TextStyle(fontSize: 16),
                      prefixText: "\$"),
                  keyboardType: TextInputType.number,
                  controller: expense,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Text("Selected Date"),
                      IconButton(
                          onPressed: () {
                            _presentdatePicker();
                          },
                          icon: const Icon(Icons.calendar_month))
                    ],
                  ),
                  Text(selectedDate == null ? "None" : selectedDate!)
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              DropdownButton(
                  value: selectedcategory,
                  items: Categories.values
                      .map((item) => DropdownMenuItem(
                          value: item, child: Text(item.name.toUpperCase())))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      selectedcategory = value;
                    });
                  }),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              const SizedBox(
                width: 16,
              ),
              ElevatedButton(
                  onPressed: createitem, child: const Text("Create")),
            ],
          )
        ],
      ),
    );
  }
}
