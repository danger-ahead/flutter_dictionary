class WordNotFoundException implements Exception {
  final String message;
  WordNotFoundException({this.message = 'Requested word was not found.'});

  @override
  String toString() => 'WordNotFoundException: $message';
}
