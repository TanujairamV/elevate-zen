import 'package:flutter_test/flutter_test.dart';
import 'package:elevate_zen/app/app.dart';

void main() {
  testWidgets('Elevate Zen app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const ElevateZenApp());
    await tester.pumpAndSettle();

    expect(find.text('Elevate Zen'), findsOneWidget);
  });
}