import 'package:flutter_test/flutter_test.dart';
import 'package:munchly/main.dart';

void main() {
  testWidgets('Munchly app launch smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MunchlyApp());
    expect(find.text('Munchly'), findsOneWidget);
    expect(find.text('Crave it. Get it.'), findsOneWidget);
  });
}
