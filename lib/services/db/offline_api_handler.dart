

import 'package:appointment/services/urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../utils/enums.dart';
import 'appoinments_db_handler.dart';

class OfflineApiHandler {

  factory OfflineApiHandler() {
    return _singleton;
  }

  OfflineApiHandler._internal();

  static final OfflineApiHandler _singleton = OfflineApiHandler._internal();
  Future<Database>? _dataBase;

  Future<Response> requestSegregation(RequestOptions options) async {
    await initiateDataBase();
   switch(options.path){
     case Urls.fetchAppointments:
       return await AppointmentsDbHandler().executeDbOperations(options, _dataBase!);

     default:
       throw DioError(requestOptions: options, type: DioErrorType.other, error: 'Not a valid service');
   }
   return Response(requestOptions: options);
  }

  Future initiateDataBase() async {
    _dataBase ??= openDatabase(
      join(await getDatabasesPath(), 'appointments.db'),
      onCreate: (db, version) async {
        Batch batch = db.batch();
        String script =  await rootBundle.loadString("assets/db/script.sql");
        List<String> scripts = script.split(";");
        for (var v in scripts) {
          if(v.isNotEmpty )
          {
            batch.execute(v.trim());
          }
        }
        await batch.commit();
      },
      version: 1,
    );
  }
}