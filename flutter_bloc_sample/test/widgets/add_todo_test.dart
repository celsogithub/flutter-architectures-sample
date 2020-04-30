import 'package:br/screens/tasks/add_todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';

void main() {
  group('When add todo is opened', () {
    testWidgets('Should display description textfield',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: AddTodo()));
      final descriptionTextField = find.byType(TextField);
      expect(descriptionTextField, findsOneWidget);
    });

    testWidgets('Should display chip component', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: AddTodo()));

      ['PERSONAL', 'WORK', 'FAMILY', 'FRIENDS'].forEach((name) {
        final chip = find.byWidgetPredicate(
          (Widget widget) => chipMatcher(widget, name),
        );
        expect(chip, findsOneWidget);
      });
    });
  });

  testWidgets('Should display create button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: AddTodo()));
    final createButton = find.text('Create');
    expect(createButton, findsOneWidget);
  });
}
