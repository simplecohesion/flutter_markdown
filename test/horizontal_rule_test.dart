// is simpler than casting
// ignore_for_file: omit_local_variable_types, lines_longer_than_80_chars

import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_test/flutter_test.dart';
import 'utils.dart';

void main() => defineTests();

void defineTests() {
  group('Horizontal Rule', () {
    testWidgets(
      '3 consecutive hyphens',
      (WidgetTester tester) async {
        const String data = '---';
        await tester.pumpWidget(boilerplate(const MarkdownBody(data: data)));

        final Iterable<Widget> widgets = selfAndDescendantWidgetsOf(
          find.byType(MarkdownBody),
          tester,
        );
        expectWidgetTypes(widgets, <Type>[
          MarkdownBody,
          Container,
          DecoratedBox,
          Padding,
          LimitedBox,
          ConstrainedBox,
        ]);
      },
    );

    testWidgets(
      '5 consecutive hyphens',
      (WidgetTester tester) async {
        const String data = '-----';
        await tester.pumpWidget(boilerplate(const MarkdownBody(data: data)));

        final Iterable<Widget> widgets = selfAndDescendantWidgetsOf(
          find.byType(MarkdownBody),
          tester,
        );
        expectWidgetTypes(widgets, <Type>[
          MarkdownBody,
          Container,
          DecoratedBox,
          Padding,
          LimitedBox,
          ConstrainedBox,
        ]);
      },
    );

    testWidgets(
      '3 asterisks separated with spaces',
      (WidgetTester tester) async {
        const String data = '* * *';
        await tester.pumpWidget(boilerplate(const MarkdownBody(data: data)));

        final Iterable<Widget> widgets = selfAndDescendantWidgetsOf(
          find.byType(MarkdownBody),
          tester,
        );
        expectWidgetTypes(widgets, <Type>[
          MarkdownBody,
          Container,
          DecoratedBox,
          Padding,
          LimitedBox,
          ConstrainedBox,
        ]);
      },
    );

    testWidgets(
      '3 asterisks separated with spaces alongside text Markdown',
      (WidgetTester tester) async {
        const String data = '# h1\n ## h2\n* * *';
        await tester.pumpWidget(boilerplate(const MarkdownBody(data: data)));

        final Iterable<Widget> widgets = selfAndDescendantWidgetsOf(
          find.byType(MarkdownBody),
          tester,
        );
        expectWidgetTypes(widgets, <Type>[
          MarkdownBody,
          Column,
          Column,
          Wrap,
          Text,
          RichText,
          SizedBox,
          Column,
          Wrap,
          Text,
          RichText,
          SizedBox,
          Container,
          DecoratedBox,
          Padding,
          LimitedBox,
          ConstrainedBox,
        ]);
      },
    );
  });
}
