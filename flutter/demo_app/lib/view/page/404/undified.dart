import 'package:flutter/material.dart';
import 'package:flutter3/app-route.dart';
import 'package:flutter3/share/context.dart';
import 'package:flutter3/view/app-view.dart';

class Page404Undified extends StatelessWidget {
  const Page404Undified({super.key, required params});

  @override
  Widget build(BuildContext context) {
    var routeArgs = AppRoute.routeArgs();
    return Scaffold(
      body: Center(
        child: Text('  is not defined'),// ${routeArgs.name}
      ),
    );
  }
}

