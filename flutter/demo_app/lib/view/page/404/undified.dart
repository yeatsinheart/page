import 'package:flutter/material.dart';
import 'package:flutter3/util/context.dart';

class Page404Undified extends StatelessWidget {
  const Page404Undified({super.key});

  @override
  Widget build(BuildContext context) {
    var routeArgs = GlobalContext.routeArgs();
    return Scaffold(
      body: Center(
        child: Text(' ${routeArgs.name} is not defined'),
      ),
    );
  }
}
