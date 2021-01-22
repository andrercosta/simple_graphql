class GraphResult {
  dynamic data;
  String contentString;
  int statusCode;
  Map<String, dynamic> errors;
  GraphResult({this.contentString, this.data, this.errors, this.statusCode});
}
