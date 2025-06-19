import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart'
    show
        expect,
        find,
        findsOneWidget,
        setUp,
        testWidgets,
        TestWidgetsFlutterBinding;
import 'package:main/src/home/presenter/home_controller.dart'
    show HomeController;
import 'package:main/src/home/presenter/home_screen.dart';
import 'package:main/src/home/presenter/home_state.dart' show HomeErrorState;
import 'package:mocktail/mocktail.dart';

class MockHomeController extends Mock implements HomeController {}

void main() {
  late HomeController homeController;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    homeController = MockHomeController();
  });

  testWidgets('displays error modal when HomeErrorState is emitted', (
    tester,
  ) async {
    final errorState = HomeErrorState("An error occurred", []);

    when(() => homeController.init()).thenAnswer((_) async => null);
    when(() => homeController.state).thenReturn(ValueNotifier(errorState));

    await tester.pumpWidget(
      MaterialApp(home: HomeScreen(homeController: homeController)),
    );

    expect(find.text('Link shortener'), findsOneWidget);
    expect(find.text('Recently shortened links'), findsOneWidget);
  });
}
