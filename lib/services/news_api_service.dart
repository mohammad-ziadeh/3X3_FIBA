import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  static const String _apiKey = '8ec61de3933747d2be15df08662385a2';
  static const String _baseUrl = 'https://newsapi.org/v2';

  Future<List<dynamic>> fetchBasketballNews({
    int page = 1,
    int pageSize = 15,
  }) async {
    final url = Uri.parse(
      '$_baseUrl/everything?q=basketball&language=en&sortBy=publishedAt&page=$page&pageSize=$pageSize&apiKey=$_apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
