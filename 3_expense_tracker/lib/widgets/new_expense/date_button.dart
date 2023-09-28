import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class DateButton extends StatelessWidget {
  const DateButton({super.key, selectedDate, required presentDatePicker})
      : _selectedDate = selectedDate,
        _presentDatePicker = presentDatePicker;

  final DateTime? _selectedDate;
  final void Function() _presentDatePicker;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(_selectedDate == null
            ? 'No date selected'
            : formatter.format(_selectedDate!)),
        IconButton(
          onPressed: _presentDatePicker,
          icon: const Icon(Icons.calendar_month),
        ),
      ],
    );
  }
}
