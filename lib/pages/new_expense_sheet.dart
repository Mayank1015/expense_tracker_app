import 'package:flutter/material.dart';
import 'package:expense_tracker/utils/util_me.dart';
import 'package:expense_tracker/models/expense_model.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({Key? key, required this.addNewExpense}) : super(key: key);

  final void Function(ExpenseModel exp) addNewExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void datePicker() async {
    final now = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(
        now.year - 1,
        now.month,
        now.day,
      ),
      lastDate: now,
    );
    setState(() {
      _selectedDate = selectedDate;
    });
    // debugPrint(selectedDate);
  }

  void onSave() {
    final selectedAmount = double.tryParse(_amountController.text);
    final isAmountValid = selectedAmount == null || selectedAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        isAmountValid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text(
              "Please check the entered data is correct, before saving it."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Okay"),
            ),
          ],
        ),
      );

      return;
    }

    ExpenseModel exp = ExpenseModel(
        title: _titleController.text.trim(),
        amount: selectedAmount,
        date: _selectedDate!,
        category: _selectedCategory,
    );
    widget.addNewExpense(exp);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 50, 15, 15),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 20,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: "Rs ",
                    label: Text("Amount"),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? "No date selected"
                          : dateFormatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: datePicker,
                      icon: const Icon(Icons.calendar_month_rounded),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (categoryItem) => DropdownMenuItem(
                        value: categoryItem,
                        child: Text(
                          categoryItem.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton.icon(
                onPressed: onSave,
                label: const Text("Save"),
                icon: const Icon(Icons.save_alt_rounded),
              )
            ],
          )
        ],
      ),
    );
  }
}
