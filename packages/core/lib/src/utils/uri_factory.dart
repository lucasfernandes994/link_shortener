
class UriFactory {

  Uri create(String baseUrl, String path) {
    return Uri.https(baseUrl, path);
  }
}