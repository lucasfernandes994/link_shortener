import 'package:injectable/injectable.dart';

@injectable
class UriFactory {
  Uri create(String baseUrl, String path) {
    return Uri.https(baseUrl, path);
  }
}
