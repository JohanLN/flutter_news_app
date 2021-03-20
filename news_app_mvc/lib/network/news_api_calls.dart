import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

// NewsApiCalls est notre class qui va gérer toutes les requetes http (get, push, update, etc...)

class NewsApiCalls {

  Future<String> get(String url) async {
    var response = await http.get(url);

    if (response.statusCode != HttpStatus.ok) throw Exception(response.body);

    return response.body;

  }

}