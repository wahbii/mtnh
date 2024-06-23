import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'article_model.dart';
const KEY = "fav_article";
class SharedPreferencesHelper {
  static Future<void> saveArticles( List<Article> articles) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(articles.map((article) => article.toJson()).toList());
    await prefs.setString(KEY, encodedData);
  }

  static Future<List<Article>> getArticles() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString(KEY);
    if (encodedData != null) {
      final List<dynamic> decodedData = jsonDecode(encodedData);
      return decodedData.map((json) => Article.fromJson(json)).toList();
    }
    return [];
  }

  static Future<void> addArticle( Article article) async {
     List<Article> currentArticles = await getArticles();
    if(currentArticles.isEmpty){
      currentArticles = [article];

    }else{
      currentArticles.add(article);

    }
    await saveArticles( currentArticles);
  }
  static Future<void> removeArticle( Article art) async {
    final List<Article> currentArticles = await getArticles();
    currentArticles.removeWhere((article) => article.id == art.id);
    await saveArticles( currentArticles);
  }


}
