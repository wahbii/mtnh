import 'dart:convert';
import 'package:fstore/models/posts/search_article.dart';
import 'package:http/http.dart' as http;
import 'article_model.dart'; // Ensure you import the Article model

class ArticleService {
  final String apiUrl = "https://mhtn.org/wp-json/wp/v2/posts/?_fields[]=post_views_count_7_day_total&_fields[]=sanitized_title&_fields[]=sanitized_excerpt&_fields[]=wpcf-stream_url&_fields[]=category_titles&_fields[]=id&_fields[]=date&per_page=50&page=1&_fields[]=mrss_thumbnail&_fields[]=content";
  final String apiSearch = "https://mhtn.org/wp-json/wp/v2/search/?search=";
  final String apiDetail ="https://mhtn.org/wp-json/wp/v2/posts/";
  final String detailAttribute = "?_fields[]=post_views_count_7_day_total&_fields[]=sanitized_title&_fields[]=sanitized_excerpt&_fields[]=wpcf-stream_url&_fields[]=category_titles&_fields[]=id&_fields[]=date&per_page=50&page=1&_fields[]=mrss_thumbnail&_fields[]=content";

  Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Article.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load articles");
    }
  }
  Future<List<PostArticle>> fetchPostArticles(String query) async {
    final response = await http.get(Uri.parse(apiSearch + query));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => PostArticle.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load post articles');
    }
  }
  Future<Article> fetchArticle(String id) async {
    final response = await http.get(Uri.parse(apiDetail +id+detailAttribute));

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return Article.fromJson(json);
    } else {
      throw Exception('Failed to load article');
    }
  }
}
