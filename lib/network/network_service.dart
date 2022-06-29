import 'package:http/http.dart' as http;
import 'package:news_updates/network/network_helper.dart';
// enums for different Network requests
enum RequestType { get, post, put }

class NetworkService {
  const NetworkService._();

  static Map<String, String> _getHeaders() =>
      {"Content-Type": "application/json"};

  // creates request for all kinds of Networks calls e.g get,post..
  static Future<http.Response>? _createRequest(
      {required RequestType requestType,
      required Uri uri,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) {
    if (requestType == RequestType.get) {
      return http.get(uri, headers: headers);
    }
    return null;
  }


  // sends request for all kinds of Networks calls e.g get,post..
  static Future<http.Response?>? sendRequest(
      {required RequestType requestType,
      required String url,
      Map<String, String>? queryParam,
      Map<String, dynamic>? body}) async {
    try {
      final header = _getHeaders();
      final _url = NetworkHelper.concatUrlQP(url, queryParam);
      final response = _createRequest(
          requestType: requestType,
          uri: Uri.parse(_url),
          headers: header,
          body: body);

      return response;
    } catch (e) {
      print('error -$e');
      return null;
    }
  }
}
