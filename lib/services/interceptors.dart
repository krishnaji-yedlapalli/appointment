
import 'package:appointment/components/network_connectivity.dart';
import 'package:appointment/utils/helper_methods.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../utils/global_variables.dart';
import 'db/offline_api_handler.dart';

initiateInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(options, handler) async {
          if(await NetworkConnectivity.isConnected()) {
            return handler.next(options);
          }else{
            return handler.resolve(await OfflineApiHandler().requestSegregation(options));
          }
        },
        onResponse:(response,handler) async {
          response.data = HelperMethods.decodeXmlResponseIntoJson(response.data);
          if(response.requestOptions.extra['storeResponse'] && !(response.requestOptions.extra['isFromLocal'] ?? false)){
            response.requestOptions.data = response.data;
            response.requestOptions.method = 'PUT';
            OfflineApiHandler().requestSegregation(response.requestOptions);
          }
          return handler.next(response); // continue
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: `handler.reject(dioError)`
        },
        onError: (DioError e, handler) {
          return  handler.next(e);//continue
        }
    ));
  }