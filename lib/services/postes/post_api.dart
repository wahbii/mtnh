
import '../../common/constants.dart';
import 'dart:convert';
import 'dart:core';
import 'dart:io' show File, HttpHeaders;

import 'package:http/http.dart' as http;


import '../../common/constants.dart';
class PostApi {
  final String url;
  final bool isRoot;

  PostApi(this.url, {this.isRoot = true});

  Uri? _getOAuthURL() {
    return '$url'.toUri();
  }



  Future<dynamic> getPosts( Map data) async {
    var url = _getOAuthURL()!;
    var client = http.Client();
    var request = http.Request('GET', url);
    var response =
    await client.send(request).then((res) => res.stream.bytesToString());
    var dataResponse = await json.decode(response);
    return dataResponse;
  }

}
