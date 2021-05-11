import 'dart:async';
import 'package:http/http.dart' as http;

class WebService {
  static Future<bool> validateServerIP(String ip) async {
    String url = "http://$ip/cgi-bin/date.py";
    var response;
    try {
      response = await http.get(url).timeout(Duration(seconds: 10));
    } on TimeoutException catch (_) {
      return false;
    } catch (e) {
      return false;
    }
    if (response.statusCode == 200) {
      /// Successful [API] call
      return true;
    } else {
      /// [API] call failed
      return false;
    }
  }
}
