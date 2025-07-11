// is simpler than casting
// ignore_for_file: omit_local_variable_types, lines_longer_than_80_chars

import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_test/flutter_test.dart';
import 'utils.dart';

void main() => defineTests();

void defineTests() {
  group('Header', () {
    testWidgets(
      'level one',
      (WidgetTester tester) async {
        const String data = '# Header';
        await tester.pumpWidget(boilerplate(const MarkdownBody(data: data)));

        final Iterable<Widget> widgets = selfAndDescendantWidgetsOf(
          find.byType(MarkdownBody),
          tester,
        );
        expectWidgetTypes(widgets, <Type>[
          MarkdownBody,
          Column,
          Wrap,
          Text,
          RichText,
        ]);
        expectTextStrings(widgets, <String>['Header']);
      },
    );
  });
}
