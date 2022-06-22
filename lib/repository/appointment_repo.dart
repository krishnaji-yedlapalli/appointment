
import 'dart:convert';

import 'package:appointment/provider.dart';
import 'package:appointment/services/base_service.dart';
import 'package:appointment/services/urls.dart';
import 'package:appointment/utils/enums.dart';

class AppointmentRepository with BaseService {

  Future<Map?> fetchAppointments() async {
    var body = '<GetAppointmentDetails><SLUsername>${CoreDataHolder().userDetails?['userName']}</SLUsername><SLPassword>${CoreDataHolder().userDetails?['password']}</SLPassword><CurrentDate>${CoreDataHolder().userDetails?['date']}</CurrentDate></GetAppointmentDetails>';
    var data = await makeRequest(url: Urls.fetchAppointments, method: RequestType.post, body: body, storeResponseInDb: true, extras: {'date' : CoreDataHolder().userDetails?['date']});
    print(jsonEncode(data));
   return data['Response'];
  }
}