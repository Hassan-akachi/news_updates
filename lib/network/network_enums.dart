enum NetworkResponseErrorType { socket, exception, responseEmpty, didNotSucced }

enum CallBackPararmeterName { all, articles }

extension CallBackParameterNameExtension on CallBackPararmeterName {
  dynamic getJson(json) {
    if (json == null) return null;
    switch (this) {
      case CallBackPararmeterName.all:
        return json;
      case CallBackPararmeterName.articles:
        return json["articles"];
    }
  }
}
