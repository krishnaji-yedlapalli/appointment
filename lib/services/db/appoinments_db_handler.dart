
import 'dart:convert';

import 'package:appointment/services/utils/abstract_db_handler.dart';
import 'package:appointment/utils/enums.dart';
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../utils/helper_methods.dart';

class AppointmentsDbHandler extends DbHandler{

  factory AppointmentsDbHandler() {
    return _singleton;
  }

  AppointmentsDbHandler._internal();

  static final AppointmentsDbHandler _singleton = AppointmentsDbHandler._internal();
  late Future<Database> _dataBase;

  @override
  Future<Response> executeDbOperations(RequestOptions options, Future<Database> dataBase) async {
   _dataBase = dataBase;
   return await performCrudOperation(options);
  }

  @override
  Future<Response> performCrudOperation(RequestOptions options) async {
    Database db = await _dataBase;
    var requestType = HelperMethods.enumFromString(RequestType.values, options.method.toLowerCase());
    var response;
    try {
      switch(requestType){
        case RequestType.post:
          final List<Map<String, dynamic>> maps = await db.query('appointments',
          );
          var index = maps.indexWhere((e) {
           return e['appointmentDate'] == options.extra['date'];
          });
          var response;
          if(index != -1){
            response = jsonDecode(maps[index]['appointments']);
          }else{
            response = {
              "Response": {
                "ResponseCode": {
                  "\$t": "SC0002"
                },
                "ResponseDescription": {
                  "\$t": "No data was present in local DB try with internet connection"
                }
              }
            };
          }
          return Response(requestOptions: options, data: response, statusCode: 200);
        case RequestType.put:
        var appointmentData = <String, Object>{};
        appointmentData['appointments'] = jsonEncode(options.data);
        appointmentData['appointmentDate'] = options.extra['date'];
        response =  await db.insert(
          'appointments',
          appointmentData,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        options.extra['isFromLocal'] = true;
        return Response(requestOptions: options, data: response, statusCode: 200);
        break;
        default :
          return Response(requestOptions: options, data: response, statusCode: 405, statusMessage: 'Method Not Allowed');
      }
    }catch(e){
      return Response(requestOptions: options, data: response, statusCode: 500, statusMessage: 'Internal Exception');
    }
  }

}