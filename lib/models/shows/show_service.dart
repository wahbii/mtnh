import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fstore/models/shows/shows_model.dart';

class ShowService {
  static const String apiUrl = 'https://mhtn.org/wp-json/wp/v2/show?&_fields[]=id&_fields[]=name&_fields[]=slug&_fields[]=count&_fields[]=description&_fields[]=link&_fields[]=_links&_fields[]=count';

  Future<List<Show>> fetchShows() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<Show> shows = jsonList.map((json) => Show.fromJson(json)).toList();
      return shows;
    } else {
      throw Exception('Failed to load shows');
    }
  }
}