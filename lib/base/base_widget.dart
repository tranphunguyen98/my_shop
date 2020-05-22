import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class PageContainer extends StatelessWidget {
  final Widget child;

  final List<SingleChildWidget> di;

  const PageContainer({this.di, this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [...di],
      child: Scaffold(
        body: child,
      ),
    );
  }
}
