import 'package:flutter/material.dart';

import '../scoped-models/main.dart';

class LogoutListTile extends StatelessWidget {
  final MainModel model;

  LogoutListTile(this.model);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Logout'),
      onTap: () => model.signout().then(
            (success) {
              if (success) {
                Navigator.pushReplacementNamed(context, '/');
              }
            },
          ),
    );
  }
}
