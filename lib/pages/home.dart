import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.user}) : super(key: key);

  final dynamic user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Text('Welcome ${user.email}'),
      ),
    );
  }
}