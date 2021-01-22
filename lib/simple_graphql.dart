library simple_graphql;

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simple_graphql/interfaces/isimple_graphql.dart';
import 'package:simple_graphql/models/graphql_result.dart';

class SimpleGraphClient implements ISimpleGraphClient {
  http.Client _client;
  final String url;
  final headers = {
    'Content-type': 'application/json; charset=utf-8',
    'Accept': 'application/json; charset=utf-8',
  };

  SimpleGraphClient(this.url) {
    _client = http.Client();
  }

  @override
  Future<GraphResult> mutation(String query, Map content, String node,
      {bool authenticated = false, String token = ""}) async {
    var sendHeader = headers;
    if (authenticated) sendHeader["Authorization"] = "Bearer ${token}";

    Map<String, dynamic> postRequest = {
      'query': query,
      'variables': content,
    };

    var request = json.encode(postRequest);
    var response = await _client.post(url, body: request, headers: sendHeader);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return GraphResult(
        contentString: response.body,
        data: data['data'][node],
        statusCode: response.statusCode,
      );
    } else {
      var data = jsonDecode(response.body);
      return GraphResult(
        contentString: response.body,
        data: data['data'][node],
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<GraphResult> query(String query, String node,
      {Map variables, bool authenticated = false, String token = ""}) async {
    var sendHeader = headers;
    if (authenticated) sendHeader["Authorization"] = "Bearer ${token}";

    Map<String, dynamic> postRequest = {
      'query': query,
      'variables': variables,
    };

    var request = json.encode(postRequest);
    var response = await _client.post(url, body: request, headers: sendHeader);

    if (response.statusCode == 200) {
      var latinConvert =
          utf8.decode(latin1.encode(response.body), allowMalformed: true);
      var data = jsonDecode(latinConvert);
      return GraphResult(
        contentString: response.body,
        data: data['data'][node],
        statusCode: response.statusCode,
      );
    } else {
      var data = jsonDecode(response.body);
      return GraphResult(
        contentString: response.body,
        data: data['data'][node],
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<GraphResult> subscription(String query, String node,
      {bool authenticated = false, String token = ""}) {
    // TODO: implement subscription
    throw UnimplementedError();
  }
}
