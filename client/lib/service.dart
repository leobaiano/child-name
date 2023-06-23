import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = 'https://api.example.com';

  Future<Map<String, dynamic>> fetchData(String country, String gender, String musicStyle, String movieCategory) async {
    final queryParams = {
      'country': country,
      'gender': gender,
      'musicStyle': musicStyle,
      'movieCategory': movieCategory,
    };
    
    final url = Uri.parse('$apiUrl/names').replace(queryParameters: queryParams);
    
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      // Parse a resposta JSON para um mapa
      Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      // Se ocorrer um erro na requisição, você pode lançar uma exceção ou retornar null
      throw Exception('Erro na requisição: ${response.statusCode}');
    }
  }
}