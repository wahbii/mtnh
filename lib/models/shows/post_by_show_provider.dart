import 'package:flutter/cupertino.dart';

import '../posts/article_model.dart';
import '../posts/article_service.dart';

class ShowPostProvider with ChangeNotifier {
  List<Article> _articles = [];

  bool _isLoading = false;

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;

  Future<void> fetchPostShows(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      ArticleService showService = ArticleService();
      _articles = await showService.fetchArticlesByShow(id);
      print("shows : $_articles");
    } catch (e) {
      // Handle error
      print(" error : ${e.toString()}");

    }

    _isLoading = false;
    notifyListeners();
  }
}
