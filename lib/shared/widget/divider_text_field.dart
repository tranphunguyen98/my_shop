import 'package:flutter/material.dart';

class DividerTextField extends StatelessWidget {
  const DividerTextField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Divider(
        height: 1,
      ),
    );
  }
}
