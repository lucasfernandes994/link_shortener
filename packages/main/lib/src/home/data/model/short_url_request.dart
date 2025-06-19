class ShortUrlRequest {
  final String url;

  ShortUrlRequest(this.url);

  Map<String, dynamic> toRequest() {
    return {"url": url};
  }
}
