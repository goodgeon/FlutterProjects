import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class CategoryDropdown extends StatefulWidget {
  CategoryDropdown({super.key, required selectedCategory})
      : _selectedCategory = selectedCategory;

  Category _selectedCategory;

  @override
  State<CategoryDropdown> createState() {
    return _CategoryDropdownState();
  }
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: widget._selectedCategory,
      items: Category.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(category.name),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          if (value == null) {
            return;
          }
          widget._selectedCategory = value;
        });
      },
    );
  }
}
