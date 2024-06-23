import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:fstore/models/posts/search_article.dart';
import 'article_model.dart';
import 'article_service.dart';
import 'package:flutter/material.dart';

class SearchNotifier extends ChangeNotifier {
  final ArticleService _articleService = ArticleService();

  List<PostArticle> searchArticles = [];
  bool _isLoadingSearch = false;
  String? _errorMessageSearch;

  bool get isLoadingSearch => _isLoadingSearch;
  String? get errorMessageSearch => _errorMessageSearch;

  Future<void> searcharticles(String search) async {
    _isLoadingSearch = true;
    notifyListeners();

    try {
      searchArticles = await _articleService.fetchPostArticles(search);
      _errorMessageSearch = null;
    } catch (error) {
      _errorMessageSearch = error.toString();
       print("error : $error");
    } finally {
      _isLoadingSearch = false;
      notifyListeners();
    }
  }
}
