import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/pages/new_expense_sheet.dart';
import 'package:expense_tracker/utils/expense_list.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _enterExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        addNewExpense: addExpense,
      ),
    );
  }

  void addExpense(ExpenseModel newExpense) {
    setState(() {
      theExpenseList.add(newExpense);
    });
  }

  void removeListItem(ExpenseModel expense) {
    final itemIndex= theExpenseList.indexOf(expense);
    setState(() {
      theExpenseList.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: const Text("Item deleted successfully"),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              theExpenseList.insert(itemIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No expense currently added."),
    );

    if (theExpenseList.isNotEmpty) {
      mainContent = ExpenseList(
        expense: theExpenseList,
        removeFromList: removeListItem,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _enterExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Text("Expense Graph"),
            Expanded(
              child: mainContent,
            ),
          ],
        ),
      ),
    );
  }
}
