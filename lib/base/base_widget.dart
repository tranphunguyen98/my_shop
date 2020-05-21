import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class PageContainer extends StatelessWidget {
  final String title;
  final Widget child;

  final List<SingleChildWidget> bloc;
  final List<Widget> actions;

  const PageContainer({this.title, this.bloc, this.actions, this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [...bloc],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
          ),
          actions: actions,
        ),
        body: child,
      ),
    );
  }
}
