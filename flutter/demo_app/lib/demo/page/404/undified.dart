import 'package:flutter/material.dart';

class Page404Undified extends StatelessWidget {
  const Page404Undified({super.key, required params});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('  is not defined'), // ${routeArgs.name}
      ),
    );
  }
}
