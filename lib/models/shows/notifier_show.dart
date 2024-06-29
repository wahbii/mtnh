import 'package:flutter/material.dart';
import 'package:fstore/models/shows/shows_model.dart';
import '../posts/article_model.dart';
import '../posts/article_service.dart';
import 'show_service.dart';

class ShowProvider with ChangeNotifier {
  List<Show> _shows = [];

  bool _isLoading = false;

  List<Show> get shows => _shows;
  bool get isLoading => _isLoading;

  Future<void> fetchShows() async {
    _isLoading = true;
    notifyListeners();

    try {
      ShowService showService = ShowService();
      _shows = await showService.fetchShows();
      print("shows : $_shows");
    } catch (e) {
      // Handle error
      print(" error : ${e.toString()}");

    }

    _isLoading = false;
    notifyListeners();
  }

}
