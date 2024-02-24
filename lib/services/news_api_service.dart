import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quantum_it_flutter_assignment/models/article_model.dart';

class ApiService {
  final endPointUrl = "newsapi.org";
  // final client = http.Client();
  final API_KEY = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"; // Your API
  final baseUri = "https://newsapi.org/v2/top-headlines";

  Future<List<Article>> getArticles() async {
    final uri = Uri.parse(
        "$baseUri?country=us&category=technology&pagesSize=10&apiKey=$API_KEY");
    final response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    List<Article> articles = [];
    var count = 0;
    for (var element in jsonData["articles"]) {
      count++;
      if (count > 10) {
        break;
      }
      if (element["urlToImage"] != null && element["description"] != null) {
        var article = Article.fromJson(element);
        articles.add(article);
      }
    }
    return articles;
  }
}
