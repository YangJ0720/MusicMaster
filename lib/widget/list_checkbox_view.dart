import 'package:flutter/material.dart';

class ListCheckboxView extends StatelessWidget {
  final bool isChecked;
  final VoidCallback? callback;

  const ListCheckboxView(this.isChecked, {Key? key, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData icon;
    MaterialColor color;
    if (isChecked) {
      icon = Icons.check_box;
      color = Colors.blue;
    } else {
      icon = Icons.check_box_outline_blank;
      color = Colors.grey;
    }
    return IconButton(
      onPressed: () => callback?.call(),
      icon: Icon(icon, color: color),
    );
  }
}
