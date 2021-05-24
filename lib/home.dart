import 'package:animatelist_1/widget/shopping_item.dart';
import 'package:flutter/material.dart';

import 'data.dart';
import 'model/shopping_item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final key = GlobalKey<AnimatedListState>();
  final items = List.from(Data.shoppingList);
  final removedItems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedList'),
      ),
      body: Container(
        color: Colors.purple[200],
        child: Column(
          children: [
            Expanded(
              child: AnimatedList(
                key: key,
                initialItemCount: items.length,
                itemBuilder: (context, index, animation) =>
                    buildItem(items[index], index, animation),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: buildInsertButton(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildInsertButton() => RaisedButton(
        onPressed: () => insertItem(0, Data.shoppingList.first),
        child: Text(
          'Insert item',
          style: TextStyle(fontSize: 20),
        ),
        color: Colors.white,
      );

  Widget buildItem(item, int index, Animation<double> animation) {
    return ShoppingItemWidget(
      item: item,
      animation: animation,
      onClicked: () => removeItem(index),
    );
  }

  void insertItem(int index, ShoppingItem item) {
    if (removedItems.length != 0) {
      items.insert(index, removedItems.first);
      removedItems.removeAt(0);
      key.currentState.insertItem(index);
    }
  }

  void removeItem(int index) {
    removedItems.add(items[index]);
    final item = items.removeAt(index);
    print(items.length);

    key.currentState.removeItem(
      index,
      (context, animation) => buildItem(item, index, animation),
    );
  }
}
