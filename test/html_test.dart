// is simpler than casting
// ignore_for_file: omit_local_variable_types, lines_longer_than_80_chars

import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_test/flutter_test.dart';
import 'utils.dart';

void main() => defineTests();

void defineTests() {
  group('HTML', () {
    testWidgets(
      'ignore tags',
      (WidgetTester tester) async {
        final List<String> data = <String>[
          'Line 1\n<p>HTML content</p>\nLine 2',
          'Line 1\n<!-- HTML\n comment\n ignored --><\nLine 2',
        ];

        for (final String line in data) {
          await tester.pumpWidget(boilerplate(MarkdownBody(data: line)));

          final Iterable<Widget> widgets = tester.allWidgets;
          expectTextStrings(widgets, <String>['Line 1', 'Line 2']);
        }
      },
    );

    testWidgets(
      "doesn't convert & to &amp; when parsing",
      (WidgetTester tester) async {
        await tester.pumpWidget(
          boilerplate(
            const Markdown(data: '&'),
          ),
        );
        expectTextStrings(tester.allWidgets, <String>['&']);
      },
    );

    testWidgets(
      "doesn't convert < to &lt; when parsing",
      (WidgetTester tester) async {
        await tester.pumpWidget(
          boilerplate(
            const Markdown(data: '<'),
          ),
        );
        expectTextStrings(tester.allWidgets, <String>['<']);
      },
    );
  });
}
