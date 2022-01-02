import 'package:flutter/foundation.dart';
import 'package:majootestcase/models/movie_model.dart';
import 'package:majootestcase/services/network_util.dart';

class RestDataSource {
  NetworkUtil netUtil = NetworkUtil();
  static const baseUrl = 'https://imdb8.p.rapidapi.com';

  // movie
  static const moviesUrl = baseUrl + "/auto-complete";

  Future<List<MovieModel>> getMovie({String? key}) async {
    Map<String, String> header = {
      "x-rapidapi-host": 'imdb8.p.rapidapi.com',
      "x-rapidapi-key": '7ebb007704msh500c797983405adp1630dbjsn9cdf293e1d19'
    };
    final queryParameters = {'q': key};

    Uri uri = Uri.parse(moviesUrl);
    final newURI = uri.replace(queryParameters: queryParameters);

    return await netUtil.get(newURI, headers: header).then((dynamic res) {
      return compute(movieFromJson, res);
    });
  }
}
