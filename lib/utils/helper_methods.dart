
import 'dart:convert';

import 'package:xml2json/xml2json.dart';

class HelperMethods {

  static const kQuoteReplacer = "¿*¿*¿*¿*";

  static T? enumFromString<T>(Iterable<T> values, String value) {
    return values.firstWhere((type) => type.toString().split(".").last == value);
  }

  static dynamic decodeXmlResponseIntoJson(String data) {
    String cleanDataString = data.replaceAll("&quot;", kQuoteReplacer);
    final Xml2Json transformer = Xml2Json();
    transformer.parse(cleanDataString);
    final json = transformer.toGData();
    return jsonDecode(json);
  }
}