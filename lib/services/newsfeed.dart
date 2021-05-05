import 'package:http/http.dart';
import 'dart:convert';

Map data;
var y;
Future<Map> getNews() async {
  try {
    Response response = await get('https://api.first.org/data/v1/news');
    data = jsonDecode(response.body);
    y = data;

    return data;
  } catch (e) {
    print("The error: $e");
  }
}
