import 'package:flutter/material.dart';
import 'package:main/src/ui/ui_decoration.dart';

class DetailScreen extends StatefulWidget {
  static const name = 'detail';
  static const path = '/detail';
  static const route = '$name/:alias';

  static Uri getRoute(String alias) {
    return Uri(path: '${path}/$alias', queryParameters: {'alias': alias});
  }

  final String alias;

  const DetailScreen({super.key, required this.alias});

  @override
  State<DetailScreen> createState() => _DetailScreenState(alias);
}

class _DetailScreenState extends State<DetailScreen> {
  final String alias;

  _DetailScreenState(this.alias);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: UiDecotation.background.dark(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24.0, // Example size
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          centerTitle: true,
          title: Text(
            "Detail Screen $alias",
            style: TextStyle(color: Colors.white, fontSize: 24.0),
          ),
        ),
        body: const Placeholder(),
      ),
    );
  }
}
