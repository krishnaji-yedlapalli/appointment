
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
    var requestType = HelperMethods.enumFromString(RequestType.values, options.method);
    var response;
    try {
      switch(requestType){
        case RequestType.get:
          final List<Map<String, dynamic>> maps = await db.query('property',
          );
          return Response(requestOptions: options, data: maps, statusCode: 200);
        default :
          return Response(requestOptions: options, data: response, statusCode: 405, statusMessage: 'Method Not Allowed');
      }
    }catch(e){
      return Response(requestOptions: options, data: response, statusCode: 500, statusMessage: 'Internal Exception');
    }
  }

}