import 'package:expense_tracker/utils/expense_list_item.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense_model.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({Key? key, required this.expense, required this.removeFromList}) : super(key: key);

  final List<ExpenseModel> expense;
  final void Function(ExpenseModel exp) removeFromList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expense[index]),
        onDismissed: (direction) {
          removeFromList(expense[index]);
        },
        child: ExpenseListItems(
          expense: expense[index],
        ),
      ),
    );
  }
}
