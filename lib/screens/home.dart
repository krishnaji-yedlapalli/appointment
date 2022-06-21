
import 'package:appointment/screens/settings.dart';
import 'package:flutter/material.dart';

import '../utils/enums.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
         children: [
           _buildButton(actionType, ActionType.settings, 'Settings'),
           _buildButton(actionType, ActionType.settings, 'Refresh Data'),
           _buildButton(actionType, ActionType.settings, 'View Appointments List'),
         ],
        ),
      )
    );
  }

  Widget _buildButton(Function(ActionType) callBack, ActionType actionType, String label) {
    return ElevatedButton(onPressed: ()=> callBack(actionType), child: Text(label));
  }

  void actionType(ActionType actionType) {
    switch(actionType){
      case ActionType.settings:
         Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
        break;
      case ActionType.refreshData:

        break;
      case ActionType.appointmentList:

        break;
    }
  }
}
