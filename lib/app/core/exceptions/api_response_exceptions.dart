class ApiResponseException implements Exception {
  final int statusCode;
  final String? reasonPhrase;
  final String? url;
  final dynamic responseBody;

  ApiResponseException(
    this.statusCode, {
    this.reasonPhrase,
    this.url,
    this.responseBody,
  });

  @override
  String toString() {
    String bodySnippet = responseBody?.toString() ?? 'null';
    if (bodySnippet.length > 100) {
      bodySnippet = '${bodySnippet.substring(0, 97)}...';
    }
    return 'ApiResponseException: Status $statusCode${reasonPhrase != null ? ' ($reasonPhrase)' : ''} for URL: $url\nResponse Body Snippet: $bodySnippet';
  }
}
