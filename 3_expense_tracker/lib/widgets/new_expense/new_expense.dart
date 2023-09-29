import 'dart:ffi';
import 'dart:io';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense/amount_textfield.dart';
import 'package:expense_tracker/widgets/new_expense/cancel_button.dart';
import 'package:expense_tracker/widgets/new_expense/category_dropdown.dart';
import 'package:expense_tracker/widgets/new_expense/date_button.dart';
import 'package:expense_tracker/widgets/new_expense/save_button.dart';
import 'package:expense_tracker/widgets/new_expense/title_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, 1, 1);
    final lastDate = DateTime(now.year + 1, 12, 31);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Invalid input'),
            content: const Text(
                'Please make sure a valid title, amount, date and category was entered.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Okay'),
              )
            ],
          );
        },
      );
    } else {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Invalid input'),
              content: const Text(
                  'Please make sure a valid title, amount, date and category was entered.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Okay'),
                )
              ],
            );
          });
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }

    widget.onAddExpense(Expense(
      title: _titleController.text,
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory,
    ));

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
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child:
                              TitleTextField(titleController: _titleController),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: AmountTextField(
                            amountController: _amountController,
                          ),
                        )
                      ],
                    )
                  else
                    TitleTextField(titleController: _titleController),
                  const SizedBox(height: 16),
                  if (width >= 600)
                    Row(
                      children: [
                        CategoryDropdown(selectedCategory: _selectedCategory),
                        const Spacer(),
                        Expanded(
                          child:
                              DateButton(presentDatePicker: _presentDatePicker),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: AmountTextField(
                            amountController: _amountController,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child:
                              DateButton(presentDatePicker: _presentDatePicker),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  if (width >= 600)
                    Row(
                      children: [
                        const Spacer(),
                        const CancelButton(),
                        SaveButton(submitExpenseData: _submitExpenseData)
                      ],
                    )
                  else
                    Row(
                      children: [
                        CategoryDropdown(selectedCategory: _selectedCategory),
                        const Spacer(),
                        const CancelButton(),
                        SaveButton(submitExpenseData: _submitExpenseData),
                      ],
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
