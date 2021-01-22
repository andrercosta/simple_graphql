import 'package:simple_graphql/models/graphql_result.dart';

abstract class ISimpleGraphClient {
  Future<GraphResult> query(String query, String node,
      {Map variables, bool authenticated = false, String token = ""});
  Future<GraphResult> mutation(String query, Map content, String node,
      {bool authenticated = false, String token = ""});
  Future<GraphResult> subscription(String query, String node,
      {bool authenticated = false, String token = ""});
}
