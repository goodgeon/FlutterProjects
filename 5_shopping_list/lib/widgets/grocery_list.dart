import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryitems = [];

  void _addItem() async {
    final newItem = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryitems.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: _groceryitems.isEmpty
          ? const Center(
              child: Text('no items'),
            )
          : ListView.builder(
              itemCount: _groceryitems.length,
              itemBuilder: (context, index) => Dismissible(
                key: ValueKey(_groceryitems[index].id),
                onDismissed: (direction) {
                  setState(() {
                    _groceryitems.remove(_groceryitems[index]);
                  });
                },
                child: ListTile(
                  leading: Container(
                    width: 24,
                    height: 24,
                    color: _groceryitems[index].category.color,
                  ),
                  title: Text(_groceryitems[index].name),
                  trailing: Text(_groceryitems[index].quantity.toString(),
                      style: Theme.of(context).textTheme.labelLarge),
                ),
              ),
            ),
    );
  }
}


// children: [
//           ...groceryItems
//               .map(
//                 (grocery) => ListTile(
//                   leading: const Icon(Icons.square),
//                   iconColor: grocery.category.color,
//                   title: Text(grocery.name),
//                   trailing: Text(grocery.quantity.toString(), style: Theme.of(context).textTheme.labelLarge),
//                 ),
//               )
//               .toList()
//         ],