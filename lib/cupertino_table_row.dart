// Copyright 2022 AndroDevelopment. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/cupertino.dart';

typedef CupertinoTableRowCallback = FutureOr<void> Function();

const double _kDefaultNavigationIndicatorSize = 18.0;

/// Creates an iOS-style leading icon widget with foreground and background
///
/// The [icon] parameter is required.
///
/// The [foregroundColor] parameter is optional. If null [CupertinoColors.white]
/// will be used.
///
/// The [backgroundColor] parameter is optional. If null [CupertinoColors.black]
/// will be used.
class CupertinoTableRowIcon extends StatelessWidget {
  const CupertinoTableRowIcon({
    required this.icon,
    this.foregroundColor = CupertinoColors.white,
    this.backgroundColor = CupertinoColors.black,
    super.key,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: backgroundColor,
      ),
      child: Center(
        child: Icon(
          icon,
          color: foregroundColor,
          size: 20,
        ),
      ),
    );
  }
}

/// Creates an iOS-style navigation indicator widget.
///
/// The [size] parameter is optional. If null [_kDefaultNavigationIndicatorSize]
/// will be used.
///
/// The [color] parameter is optional. If null [CupertinoColors.opaqueSeparator]
/// the from context resolved dynamic color will be used.

class CupertinoTableRowNavigationIndicator extends StatelessWidget {
  const CupertinoTableRowNavigationIndicator({
    super.key,
    this.size,
    this.color,
  });

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      CupertinoIcons.forward,
      size: size ?? _kDefaultNavigationIndicatorSize,
      color: color ?? CupertinoColors.secondaryLabel.resolveFrom(context),
    );
  }
}

// Content padding determined via SwiftUI's `Form` view in the iOS 14.2 SDK.
const EdgeInsetsGeometry _kDefaultPadding =
    EdgeInsetsDirectional.fromSTEB(19.0, 6.0, 14.0, 6.0);

const double _kDefaultLeadingSpace = 29.0;

/// Creates an iOS-style split table row with a leading widget, title widget and trailing widget.
/// Also provides a space for helper widgets that appear underneath.
///
/// The [title] parameter is required. This widget is displayed on the top left of
/// the row.
///
/// The [leading] parameter is optional and is displayed at the start of the
/// row.
///
/// The [trailing] parameter is optional and is displayed at the end of the
/// row. It might be an icon like an indicator or an info button
///
/// The [padding] parameter is used to pad the contents of the row. It defaults
/// to the standard iOS padding. If no edge insets are intended, explicitly
/// pass [EdgeInsets.zero] to [padding].
///
/// The [helper] parameter is optional widget targeted at
/// displaying more information about the row. Placed
/// underneath the [title], and will expand the row's height to
/// accommodate for their presence. When a [Text] is given to [helper], it will
/// be shown in secondary label coloring and medium-weighted font.
///
/// The [onPress] parameter is optional and would trigger the
/// [CupertinoTableRowCallback] Future Function to be executed. It is meant to
/// be used for example with the trailing navigation indicator icon or info button

class CupertinoTableRow extends StatelessWidget {
  const CupertinoTableRow({
    super.key,
    required this.title,
    this.leading,
    this.helper,
    this.trailing,
    this.padding,
    this.onPress,
  });

  /// The [onPress] triggers the [CupertinoTableRowCallback] Future Function
  final CupertinoTableRowCallback? onPress;

  /// Title widget.
  ///
  /// The [title] appears in primary label coloring, and gives the row a name.
  final Widget title;

  /// A widget that is displayed at the start of the row.
  ///
  /// The [leading] parameter is displayed at the start of the row.
  /// It is recommended to use an [Icon] or [CupertinoTableRowIcon].
  /// If null, the [title] and (if present) the [helper] widgets will move
  /// to the very left in the row.
  final Widget? leading;

  /// A widget that is displayed underneath the [title] widget.
  ///
  /// The [helper] appears in [CupertinoColors.secondaryLabel] coloring,
  /// and is meant to inform the user about interaction with the row.
  /// The row becomes taller in order to display the [helper] widget underneath [title].
  /// If null, the row is shorter.
  final Widget? helper;

  /// A widget that is displayed at the start of the row.
  ///
  /// The [trailing] parameter is displayed centered at the end of the row.
  /// It is meant to be for example an info button or an indicator for the next
  /// level in a hierarchy
  /// to the very left in the row.
  final Widget? trailing;

  /// Content padding for the row.
  ///
  /// Defaults to the standard iOS padding for form rows. If no edge insets are
  /// intended, explicitly pass [EdgeInsets.zero] to [padding].
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    double defaultSize = 44 * MediaQuery.of(context).textScaleFactor;
    double defaultWithSize = 57 * MediaQuery.of(context).textScaleFactor;
    debugPrint("TextScaleFactor Size: ${MediaQuery.of(context).textScaleFactor}");
    debugPrint("Default Size: $defaultSize");
    debugPrint("Default Size: $defaultWithSize");

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        if (onPress != null) await onPress!();
      },
      child: SizedBox(
        height: helper == null ? defaultSize : defaultWithSize,
        child: Padding(
          padding: padding ?? _kDefaultPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (leading != null)
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: SizedBox(
                    height: _kDefaultLeadingSpace,
                    width: _kDefaultLeadingSpace,
                    child: leading,
                  ),
                ),
              Expanded(
                child: Column(
                  children: [
                    Flexible(
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: title,
                      ),
                    ),
                    if (helper != null)
                      Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: DefaultTextStyle(
                            style: TextStyle(
                              color: CupertinoColors.secondaryLabel
                                  .resolveFrom(context),
                              fontWeight: FontWeight.w500,
                            ),
                            child: helper!,
                          ))
                  ],
                ),
              ),
              if (trailing != null)
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: trailing!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
