// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter/cupertino.dart' show CupertinoTheme;
import 'package:flutter/material.dart' show Theme;
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

/// Type for a function that creates image widgets.
typedef ImageBuilder =
    Widget Function(
      Uri uri,
      String? imageDirectory,
      double? width,
      double? height,
    );

/// A default image builder handling http/https, resource, and file URLs.
// ignore: prefer_function_declarations_over_variables
final ImageBuilder kDefaultImageBuilder =
    (Uri uri, String? imageDirectory, double? width, double? height) {
      if (uri.scheme == 'http' || uri.scheme == 'https') {
        return Image.network(
          uri.toString(),
          width: width,
          height: height,
          errorBuilder: kDefaultImageErrorWidgetBuilder,
        );
      } else if (uri.scheme == 'data') {
        return _handleDataSchemeUri(uri, width, height);
      } else if (uri.scheme == 'resource') {
        return Image.asset(
          uri.path,
          width: width,
          height: height,
          errorBuilder: kDefaultImageErrorWidgetBuilder,
        );
      } else {
        final fileUri = imageDirectory != null
            ? Uri.parse(imageDirectory + uri.toString())
            : uri;
        if (fileUri.scheme == 'http' || fileUri.scheme == 'https') {
          return Image.network(
            fileUri.toString(),
            width: width,
            height: height,
            errorBuilder: kDefaultImageErrorWidgetBuilder,
          );
        } else {
          try {
            return Image.file(
              File.fromUri(fileUri),
              width: width,
              height: height,
              errorBuilder: kDefaultImageErrorWidgetBuilder,
            );
          } catch (error, stackTrace) {
            // Handle any invalid file URI's.
            return Builder(
              builder: (BuildContext context) {
                return kDefaultImageErrorWidgetBuilder(
                  context,
                  error,
                  stackTrace,
                );
              },
            );
          }
        }
      }
    };

/// A default error widget builder for handling image errors.
Widget kDefaultImageErrorWidgetBuilder(
  BuildContext context,
  Object error,
  StackTrace? stackTrace,
) {
  return const SizedBox();
}

/// A default style sheet generator.
MarkdownStyleSheet kFallbackStyle(
  BuildContext context,
  MarkdownStyleSheetBaseTheme? baseTheme,
) {
  MarkdownStyleSheet result;
  switch (baseTheme) {
    case MarkdownStyleSheetBaseTheme.platform:
      result = (Platform.isIOS || Platform.isMacOS)
          ? MarkdownStyleSheet.fromCupertinoTheme(
              CupertinoTheme.of(context),
            )
          : MarkdownStyleSheet.fromTheme(Theme.of(context));
    case MarkdownStyleSheetBaseTheme.cupertino:
      result = MarkdownStyleSheet.fromCupertinoTheme(
        CupertinoTheme.of(context),
      );
    case MarkdownStyleSheetBaseTheme.material:
    case null:
      result = MarkdownStyleSheet.fromTheme(Theme.of(context));
  }

  return result.copyWith(textScaler: MediaQuery.textScalerOf(context));
}

Widget _handleDataSchemeUri(
  Uri uri,
  double? width,
  double? height,
) {
  final mimeType = uri.data!.mimeType;
  if (mimeType.startsWith('image/')) {
    return Image.memory(
      uri.data!.contentAsBytes(),
      width: width,
      height: height,
      errorBuilder: kDefaultImageErrorWidgetBuilder,
    );
  } else if (mimeType.startsWith('text/')) {
    return Text(uri.data!.contentAsString());
  }
  return const SizedBox();
}
