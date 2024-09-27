import 'dart:convert';
import 'package:http/http.dart' as http;

class FoodsApiProvider {
  final String apiUrl = 'http://192.168.111.123:8000/api/foods/';

  Future<List<dynamic>> fetchFoods() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        return json.decode(response.body) ?? [];
      } else {
        throw Exception(
            'Error al obtener los alimentos. Código: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error al obtener los alimentos.');
    }
  }
}
