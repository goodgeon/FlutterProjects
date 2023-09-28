import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required submitExpenseData})
      : _submitExpenseData = submitExpenseData;

  final void Function() _submitExpenseData;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _submitExpenseData,
      child: const Text('Save Expense'),
    );
  }
}
