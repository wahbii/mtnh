import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:fstore/models/posts/search_article.dart';
import 'article_model.dart';
import 'article_service.dart';

class ArticleNotifier extends ChangeNotifier {
  final ArticleService _articleService = ArticleService();

  List<Article> _articles = [];
  Article? article = null ;
  bool _isLoading = false;

  String? _errorMessage;

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadArticles() async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles = await _articleService.fetchArticles();
      print("articles :${articles.length}");
      article = _articles.firstOrNull ;
      _errorMessage = null;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }



  String getLiveUrl(){
    return "https://amg17544-amg17544c1-mentalhealthtvnetwork-worldwide-2864.playouts.now.amagi.tv/playlist/amg17544-mentalhealthtelevisionnetworkfast-mentalhealthtv-mentalhealthtvnetworkworldwide/playlist.m3u8?app_bundle=com.main.mhtn&amp;app_name=com.main.mhtn&amp;app_store_url=&amp;country=MAR&amp;language=ENG";
  }


  List<MapEntry<String, List<Article>>> getDataByCat(){


    Map<String, List<Article>> groupedByCategory = {};

    articles.forEach((article) {
      article.categoryTitles.forEach((category) {
        if (!groupedByCategory.containsKey(category)) {
          groupedByCategory[category] = [];
        }
        groupedByCategory[category]!.add(article);
      });
    });

    // Convert to List of pairs (List<String, List<Article>>)
    List<MapEntry<String, List<Article>>> pairs = groupedByCategory.entries.toList();



      return pairs ;

// Define your Article, Title, and Excerpt classes here as per your original structure

  }
}

