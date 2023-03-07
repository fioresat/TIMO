import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class FetchHelper {
  FetchHelper();

  Future<dynamic> getData(String quoteID) async {
    final fullUrl =
        'https://timo-e97a8-default-rtdb.firebaseio.com/quotes/$quoteID.json';

    try {
      http.Response response = await http.get(Uri.parse(fullUrl));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return body;
      } else {
        return 1;
      }
    } on SocketException catch (_) {
      return 0;
    }
  }
}
