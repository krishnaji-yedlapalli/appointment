import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:appointment/services/urls.dart';
import 'package:appointment/utils/enums.dart';
import 'package:http/http.dart' as http;

class BaseService {
  Future<dynamic> makeRequest<T>(
      {required String? url,
      String? baseUrl,
      dynamic body,
      String? contentType,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      RequestType method = RequestType.get,
      }) async {
    var uri;

    if (queryParameters == null) {
      uri = Uri.parse('${baseUrl ?? Urls.baseUrl}$url');
    } else {
      String queryString = Uri(queryParameters: queryParameters).query;
      uri = Uri.parse(
          '${baseUrl ?? Urls.baseUrl}$url?$queryString');
    }

    if (headers == null ||
        headers[HttpHeaders.contentTypeHeader] == 'application/json') {
      body = jsonEncode(body);
    }

    var header = headers ??
        {
          HttpHeaders.contentTypeHeader: 'application/json',
        };

    http.Response response;
      switch (method) {
        case RequestType.get:
          response = await http.get(uri);
          break;
        case RequestType.put:
          response = await http.put(uri, body: json.encode(body));
          break;
        case RequestType.post:
          response = await http.post(uri, headers: header, body: body);
          break;
        case RequestType.delete:
          response = await http.delete(uri, body: json.encode(body));
      }
      return json.decode(utf8.decode(response.bodyBytes));
  }
}