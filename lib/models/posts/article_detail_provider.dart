
import 'package:flutter/cupertino.dart';

import 'article_model.dart';
import 'article_service.dart';

class ArticleDetailNotifier extends ChangeNotifier {
  final ArticleService _articleService = ArticleService();

  Article? _article = null ;
  bool _isLoading = false;

  String? _errorMessage;

  Article? get article => _article;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadArticles(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      _article = await _articleService.fetchArticle(id);
      _errorMessage = null;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }




}

