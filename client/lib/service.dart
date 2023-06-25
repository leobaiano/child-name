import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = 'http://192.168.1.4:3000';

  Future<Map<String, dynamic>> fetchData(String country, String gender, String musicStyle, String movieCategory) async {
    final queryParams = {
      'country': country,
      'gender': gender,
      'musicStyle': musicStyle,
      'movieCategory': movieCategory,
    };
    
    final url = Uri.parse('$apiUrl/names').replace(queryParameters: queryParams);

    print(url);
    
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      // Se ocorrer um erro na requisição, você pode lançar uma exceção ou retornar null
      throw Exception('Erro na requisição: ${response.statusCode}');
    }
  }
}