// is simpler than casting
// ignore_for_file: omit_local_variable_types, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_test/flutter_test.dart';
import 'utils.dart';

void main() => defineTests();

void defineTests() {
  group('Text Scaler', () {
    testWidgets(
      'should use style textScaler in RichText',
      (WidgetTester tester) async {
        const TextScaler scaler = TextScaler.linear(2);
        const String data = 'Hello';
        await tester.pumpWidget(
          boilerplate(
            MarkdownBody(
              styleSheet: MarkdownStyleSheet(textScaler: scaler),
              data: data,
            ),
          ),
        );

        final RichText richText = tester.widget(find.byType(RichText));
        expect(richText.textScaler, scaler);
      },
    );

    testWidgets(
      'should use MediaQuery textScaler in RichText',
      (WidgetTester tester) async {
        const TextScaler scaler = TextScaler.linear(2);
        const String data = 'Hello';
        await tester.pumpWidget(
          boilerplate(
            const MediaQuery(
              data: MediaQueryData(textScaler: scaler),
              child: MarkdownBody(
                data: data,
              ),
            ),
          ),
        );

        final RichText richText = tester.widget(find.byType(RichText));
        expect(richText.textScaler, scaler);
      },
    );

    testWidgets(
      'should use MediaQuery textScaler in SelectableText.rich',
      (WidgetTester tester) async {
        const TextScaler scaler = TextScaler.linear(2);
        const String data = 'Hello';
        await tester.pumpWidget(
          boilerplate(
            const MediaQuery(
              data: MediaQueryData(textScaler: scaler),
              child: MarkdownBody(
                data: data,
                selectable: true,
              ),
            ),
          ),
        );

        final SelectableText selectableText = tester.widget(
          find.byType(SelectableText),
        );
        expect(selectableText.textScaler, scaler);
      },
    );
  });
}
