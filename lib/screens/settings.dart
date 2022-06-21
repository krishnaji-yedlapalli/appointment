

import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  var userNameCtrl = TextEditingController();
  var pwdCtrl = TextEditingController();
  var dateCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Column(
        children: [
          TextFormField(
            controller: userNameCtrl,
          ),
          TextFormField(
            controller: pwdCtrl,
          ),
          TextFormField(
            controller: dateCtrl,
          ),
        ],
      ),
    );
  }
}
