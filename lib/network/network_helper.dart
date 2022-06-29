import 'dart:convert';

import 'package:news_updates/network/network_enums.dart';
import 'package:news_updates/network/network_typedef.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  const NetworkHelper._();

  // builds the url
  static String concatUrlQP(String url, Map<String, String>? queryParameters) {
    if (url.isEmpty) return url;
    if (queryParameters == null || queryParameters.isEmpty) {
      return url;
    }
    final StringBuffer stringBuffer = StringBuffer("$url?");
    queryParameters.forEach((key, value) {
      if (value.trim() == '') return;
      if (value.trim() == " ") throw Exception("Invalid Input Exception");
      stringBuffer.write("$key=$value&");
    });
    final result = stringBuffer.toString();
    return result.substring(0, result.length - 1);
  }

  static bool _isValidResponse(json) {
    return json != null &&
        json["status"] != null &&
        json["status"] == "ok" &&
        // specific check  to the article
        json["articles"] != null;
  }

  static R filterResponse<R>({
    required NetworkCallBack callBack,
    required http.Response? response,
    required NetworkOnFailureCallBackWithMessage onFailureCallBackWithMessage,
    CallBackPararmeterName parameterName = CallBackPararmeterName.all,
  }) {
    try {
      if (response == null || response.body.isEmpty) {
        return onFailureCallBackWithMessage(
            NetworkResponseErrorType.responseEmpty, "Empty response");
      }

      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (_isValidResponse(json)) {
          return callBack(parameterName.getJson(json));
        }
      } else if (response.statusCode == 1708) {
        return onFailureCallBackWithMessage(
            NetworkResponseErrorType.socket, "Error Socket");
      }
      return onFailureCallBackWithMessage(
          NetworkResponseErrorType.didNotSucced, "inspect code or api ");
    } catch (e) {
      return onFailureCallBackWithMessage(
          NetworkResponseErrorType.exception, "Error Respond -$e");
    }
  }
}
