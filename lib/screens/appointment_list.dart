
import 'package:appointment/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
      body: appointmentDetails == null || appointmentDetails['ResponseCode']['\$t'] != 'SC0001' ? _buildMessage(appointmentDetails) : ListView.builder(
          itemCount: appointmentDetails['Appointments']['Appointment']?.length ?? 0,
          itemBuilder: (_, index) => _buildAppointment(appointmentDetails['Appointments']['Appointment'][index])
    ));
  }

  Widget _buildMessage(Map? appointmentDetails) {
    return Center(
      child: Text('${appointmentDetails == null ? 'Refresh the data once' : appointmentDetails['ResponseDescription']['\$t']}',
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  Widget _buildAppointment(Map appointment) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
      color: const Color.fromRGBO(248, 236, 248, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Wrap(
                direction: Axis.vertical,
                children : [
                  Text('Customer Name : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo),),
                  Text('${appointment['CustomerDetails']['CustomerTitle']['\$t']} '
                      '${appointment['CustomerDetails']['CustomerForename']['\$t'] ?? ''} ${appointment['CustomerDetails']['CustomerSurname']['\$t'] ?? ''}', style: TextStyle(fontWeight: FontWeight.w600),),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child:  Text('Customer Address : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo),),
                  ),
                  Text('Comapany Name : ${appointment['CustomerDetails']['CustomerCompanyName']['\$t'] ?? '-'} \n'
                      'Building Name : ${appointment['CustomerDetails']['CustomerBuildingName']['\$t'] ?? '-'} \n'
                      'Customer Street : ${appointment['CustomerDetails']['CustomerStreet']['\$t'] ?? '-'} \n'
                      'Customer Address Area : ${appointment['CustomerDetails']['CustomerAddressArea']['\$t'] ?? '-'} \n'
                      'Customer Address Town : ${appointment['CustomerDetails']['CustomerAddressTown']['\$t'] ?? '-'} \n'
                      'Customer Country : ${appointment['CustomerDetails']['CustomerCounty']['\$t'] ?? '-'}'),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text('Appointment Details : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo),),
                  ),
                  Text('Warranty Details : ${appointment['WarrantyDetails']['ChargeType']['\$t'] ?? '-'} \n'
                      'Job Type : ${appointment['WarrantyDetails']['JobType']['\$t'] ?? '-'}'),

                ]
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: () => openDialPad('Job Type : ${appointment['CustomerDetails']['CustomerMobileNo']['\$t']}'), icon: Icon(Icons.call, color: Colors.green, size: 30,)),
              IconButton(onPressed: () =>openMaps('${appointment['CustomerDetails']['CustomerPostcode']['\$t']}'), icon: const Icon(Icons.location_on, color: Colors.blue, size: 30,)),
            ],
          )
        ],
      ),
    );
  }

  void openDialPad(String? mobileNumber){
    var uri = Uri(scheme: 'tel', path: mobileNumber.toString());
    canLaunchUrl(uri).then((bool result) {
     launchUrl(uri);
    });
  }

  void openMaps(String postcode) async {
    if (!await launch(
    'https://www.google.com/maps/search/?api=1&query=$postcode',
    )) {
    }
  }
}
