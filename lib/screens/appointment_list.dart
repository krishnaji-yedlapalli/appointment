
import 'package:appointment/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppointmentList extends StatefulWidget {
  const AppointmentList({Key? key}) : super(key: key);

  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  @override
  Widget build(BuildContext context) {
    var appointmentDetails = CoreDataHolder().appointmentData;
    return Scaffold(
      appBar: AppBar(
        title: Text('${appointmentDetails?['Defaults']?['SLUsername']?['\$t'] ?? ''}'),
      ),
      body: appointmentDetails?['ResponseCode']['\$t'] != 'SC0001' ? _buildMessage(appointmentDetails) : ListView.builder(
          itemCount: appointmentDetails?['Appointments']['Appointment']?.length ?? 0,
          itemBuilder: (_, index) => _buildAppointment(appointmentDetails?['Appointments']['Appointment'][index])
    ));
  }

  Widget _buildMessage(Map? appointmentDetails) {
    return Center(
      child: Text('${appointmentDetails?['ResponseDescription']['\$t']}',
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  Widget _buildAppointment(Map appointment) {
    return Wrap(
      direction: Axis.vertical,
      children : [
     Text('${appointment['CustomerDetails']['CustomerTitle']['\$t']} '
          '${appointment['CustomerDetails']['CustomerForename']['\$t'] ?? ''} ${appointment['CustomerDetails']['CustomerSurname']['\$t'] ?? ''}'),
     Text('Comapany Name : ${appointment['CustomerDetails']['CustomerCompanyName']['\$t'] ?? '-'} \n'
          'Building Name : ${appointment['CustomerDetails']['CustomerBuildingName']['\$t'] ?? '-'} \n'
          'Customer Street : ${appointment['CustomerDetails']['CustomerStreet']['\$t'] ?? '-'} \n'
          'Customer Address Area : ${appointment['CustomerDetails']['CustomerAddressArea']['\$t'] ?? '-'} \n'
          'Customer Address Town : ${appointment['CustomerDetails']['CustomerAddressTown']['\$t'] ?? '-'} \n'
          'Customer Country : ${appointment['CustomerDetails']['CustomerCounty']['\$t'] ?? '-'}'),
        Text('Warranty Details : ${appointment['WarrantyDetails']['ChargeType']['\$t'] ?? '-'} \n'
            'Job Type : ${appointment['WarrantyDetails']['JobType']['\$t'] ?? '-'}'),
         IconButton(onPressed: () => openDialPad('Job Type : ${appointment['CustomerDetails']['CustomerMobileNo']['\$t']}'), icon: Icon(Icons.call)),
         IconButton(onPressed: openMaps, icon: const Icon(Icons.location_on)),
    ]
    );
  }

  void openDialPad(String? mobileNumber){

  }

  void openMaps() {

  }
}
