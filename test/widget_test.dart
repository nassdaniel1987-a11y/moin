import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Note: The package name is 'nutri_scan' as defined in pubspec.yaml
import 'package:nutri_scan/main.dart';
import 'package:nutri_scan/screens/dashboard_screen.dart';
import 'package:nutri_scan/screens/diary_screen.dart';
import 'package:nutri_scan/screens/goals_screen.dart';

void main() {
  testWidgets('MainScreen navigation and initial state test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NutriScanApp());

    // === VERIFY INITIAL STATE ===
    // Verify that DashboardScreen is shown by default.
    expect(find.byType(DashboardScreen), findsOneWidget);
    expect(find.byType(DiaryScreen), findsNothing);
    expect(find.byType(GoalsScreen), findsNothing);

    // Verify the AppBar title is correct.
    expect(find.text('NutriScan'), findsOneWidget);

    // Verify the FloatingActionButton with the scanner icon is present.
    expect(find.widgetWithIcon(FloatingActionButton, Icons.qr_code_scanner), findsOneWidget);

    // Verify the BottomNavigationBar items are present.
    expect(find.byIcon(Icons.dashboard), findsOneWidget);
    expect(find.byIcon(Icons.book), findsOneWidget);
    expect(find.byIcon(Icons.flag), findsOneWidget);


    // === TEST NAVIGATION to Diary ===
    await tester.tap(find.byIcon(Icons.book));
    await tester.pumpAndSettle(); // pumpAndSettle to allow for animations

    // Verify that DiaryScreen is now shown.
    expect(find.byType(DashboardScreen), findsNothing);
    expect(find.byType(DiaryScreen), findsOneWidget);
    expect(find.text('Diary Screen'), findsOneWidget);


    // === TEST NAVIGATION to Goals ===
    await tester.tap(find.byIcon(Icons.flag));
    await tester.pumpAndSettle();

    // Verify that GoalsScreen is now shown.
    expect(find.byType(DiaryScreen), findsNothing);
    expect(find.byType(GoalsScreen), findsOneWidget);
    expect(find.text('Goals Screen'), findsOneWidget);
  });
}
