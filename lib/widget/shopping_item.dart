import 'package:animatelist_1/model/shopping_item.dart';
import 'package:flutter/material.dart';

class ShoppingItemWidget extends StatelessWidget {
  final ShoppingItem item;
  final Animation animation;
  final VoidCallback onClicked;

  const ShoppingItemWidget(
      {Key key,
      @required this.item,
      @required this.animation,
      @required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          leading: CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(item.urlImage),
          ),
          title: Text(
            item.title,
            style: TextStyle(fontSize: 20),
          ),
          trailing: IconButton(
            icon: Icon(Icons.check_circle, color: Colors.green),
            onPressed: onClicked,
          ),
        ),
      ),
    );
  }
}
