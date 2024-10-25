import 'package:flutter/material.dart';

class GenericBox<T> extends StatelessWidget {
  final String title;
  final IconData editIcon;
  final VoidCallback onEdit;
  final IconData deleteIcon;
  final VoidCallback onDelete;

  GenericBox({
    required this.title,
    required this.editIcon,
    required this.onEdit,
    required this.deleteIcon,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 240,
                  child: Text(
                    title,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onEdit,
                  icon: Icon(editIcon),
                  iconSize: 30,
                  color: Colors.black,
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(deleteIcon),
                  iconSize: 30,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
