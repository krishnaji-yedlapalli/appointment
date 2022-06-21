
import 'package:appointment/provider.dart';
import 'package:appointment/screens/appointment_list.dart';
import 'package:appointment/screens/settings.dart';
import 'package:flutter/material.dart';

import '../repository/appointment_repo.dart';
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
           _buildButton(actionType, ActionType.refreshData, 'Refresh Data'),
           _buildButton(actionType, ActionType.appointmentList, 'View Appointments List'),
         ],
        ),
      )
    );
  }

  Widget _buildButton(Function(ActionType) callBack, ActionType actionType, String label) {
    return ElevatedButton(onPressed: ()=> callBack(actionType), child: Text(label));
  }

  Future<void> actionType(ActionType actionType) async {
    switch(actionType){
      case ActionType.settings:
         Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
        break;
      case ActionType.refreshData: case ActionType.appointmentList:
        if(CoreDataHolder().userDetails == null){
          const snackBar = SnackBar(
            content: Text('Hey! provide login details in settings Page !!!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return;
        }

        if(ActionType.refreshData == actionType) {
         var response = await AppointmentRepository().fetchAppointments();
         CoreDataHolder().appointmentData = response;
        }else {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AppointmentList()));
        }
        break;
    }
  }
}
