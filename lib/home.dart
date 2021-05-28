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
  final items2 = List.from(Data.shoppingList);
  final removedItems = [];
  TextEditingController _controller = TextEditingController();
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
            TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'Search'),
              onChanged: (text) {
                print(text);
                List deleteList = [];
                String textLowercase = text.toLowerCase();
                items2.asMap().forEach((index, element) {
                  String foodLowercase = element.title.toLowerCase();
                  if (!foodLowercase.contains(textLowercase)) {
                    deleteList.add(element);
                  } else if (foodLowercase.contains(textLowercase) &&
                      items.indexOf(element) == -1) {
                    insertItem(items.length, element);
                  }
                });

                deleteList.forEach((element) {
                  int deleteIndex = items.indexOf(element);
                  if (items.indexOf(element) != -1) {
                    removeItem(deleteIndex);
                  }
                });
              },
            ),
            Expanded(
              child: AnimatedList(
                key: key,
                initialItemCount: items.length,
                itemBuilder: (context, index, animation) =>
                    buildItem(items[index], index, animation),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
