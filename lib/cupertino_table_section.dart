// Copyright 2022 AndroDevelopment. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';

// Standard header margin, determined from SwiftUI's Forms in iOS 14.2 SDK.
const EdgeInsetsDirectional _kDefaultHeaderMargin =
    EdgeInsetsDirectional.fromSTEB(17.0, 16.0, 17.0, 10.0);

// Standard footer margin, determined from SwiftUI's Forms in iOS 14.2 SDK.
const EdgeInsetsDirectional _kDefaultFooterMargin =
    EdgeInsetsDirectional.fromSTEB(17.0, 0.0, 17.0, 10.0);

// Used for iOS "Inset Grouped" margin, determined from SwiftUI's Forms in
// iOS 14.2 SDK.
const EdgeInsetsDirectional _kDefaultInsetGroupedRowsMargin =
    EdgeInsetsDirectional.fromSTEB(17.0, 0.0, 17.0, 10.0);

// Used for iOS "Inset Grouped" border radius, estimated from SwiftUI's Forms in
// iOS 14.2 SDK.
const BorderRadius _kDefaultInsetGroupedBorderRadius =
    BorderRadius.all(Radius.circular(10.0));

// Used to differentiate the plain section with the leaded section.
enum _CupertinoTableSectionType { plain, leaded }

/// An iOS-style table section.
///
/// Creates a table section that mimics standard "Inset Grouped" iOS lists and tables.
/// Lists and tables present data in one or more columns of rows.
///
/// See Details here:
/// https://developer.apple.com/design/human-interface-guidelines/components/layout-and-organization/lists-and-tables/
///
/// The plain [CupertinoTableSection] constructor creates a round-edged and
/// padded section with longer Divider due to the space needed for the leading widgets.
/// Creates an iOS-style header, rows, and the dividers
/// between rows. Does not create borders on top and bottom of the rows.
///
/// The [header] parameter sets the table section header. The section header
/// lies above the [children] rows, with margins that match the iOS style.
///
/// The [footer] parameter sets the table section footer. The section footer
/// lies below the [children] rows.
///
/// The [children] parameter is required and sets the list of rows shown in
/// the section. It is recommended that only [CupertinoTableRow] widget
/// be included in the [children] list in order to retain the iOS look.
///
/// The [margin] parameter sets the spacing around the content area of the
/// section encapsulating [children], and defaults to the standard
/// notched-style iOS form padding.
///
/// The [backgroundColor] parameter sets the background color behind the
/// section. If null, defaults to [CupertinoColors.systemGroupedBackground].
///
/// {@macro flutter.material.Material.clipBehavior}
class CupertinoTableSection extends StatelessWidget {
  const CupertinoTableSection({
    super.key,
    required this.children,
    this.header,
    this.footer,
    this.margin = _kDefaultInsetGroupedRowsMargin,
    this.backgroundColor = CupertinoColors.systemGroupedBackground,
    this.clipBehavior = Clip.none,
  })  : _type = _CupertinoTableSectionType.plain,
        assert(children.length > 0);

  /// The [CupertinoTableSection.leaded] constructor creates a round-edged and
  /// padded section with shorter divider due to the space needed for leading widgets.
  ///
  /// The [header] parameter sets the table section header. The section header
  /// lies above the [children] rows, with margins that match the iOS style.
  ///
  /// The [footer] parameter sets the table section footer. The section footer
  /// lies below the [children] rows.
  ///
  /// The [children] parameter is required and sets the list of rows shown in
  /// the section. It is recommended that only [CupertinoTableRow] widget
  /// be included in the [children] list in order to retain the iOS look.
  ///
  /// The [margin] parameter sets the spacing around the content area of the
  /// section encapsulating [children], and defaults to the standard
  /// notched-style iOS form padding.
  ///
  /// The [backgroundColor] parameter sets the background color behind the
  /// section. If null, defaults to [CupertinoColors.systemGroupedBackground].
  ///
  /// {@macro flutter.material.Material.clipBehavior}

  const CupertinoTableSection.leaded({
    super.key,
    required this.children,
    this.header,
    this.footer,
    this.margin = _kDefaultInsetGroupedRowsMargin,
    this.backgroundColor = CupertinoColors.systemGroupedBackground,
    this.clipBehavior = Clip.none,
  })  : _type = _CupertinoTableSectionType.leaded,
        assert(children.length > 0);

  final _CupertinoTableSectionType _type;

  /// Sets the table section header. The section header lies above the
  /// [children] rows.
  final Widget? header;

  /// Sets the table section footer. The section footer lies below the
  /// [children] rows.
  final Widget? footer;

  /// Margin around the content area of the section encapsulating [children].
  final EdgeInsetsGeometry margin;

  /// The list of rows in the section.
  ///
  /// It is recommended that only [CupertinoTableRow] widget be included
  /// in the [children] list in order to retain the iOS look.
  final List<Widget> children;

  /// Sets the background color behind the section.
  ///
  /// Defaults to [CupertinoColors.systemGroupedBackground].
  final Color backgroundColor;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none], and must not be null.
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final Color dividerColor = CupertinoColors.separator.resolveFrom(context);
    final double dividerHeight = 1.0 / MediaQuery.of(context).devicePixelRatio;

    // Long divider for rows without leading widgets.
    // Used in _CupertinoTableSectionType.plain mode
    final Widget longDivider = Container(
      margin: const EdgeInsetsDirectional.only(start: 15.0),
      color: dividerColor,
      height: dividerHeight,
    );

    // Short divider is used between rows.
    // The value of the starting inset is 65.0
    // Used in _CupertinoTableSectionType.leaded mode
    final Widget shortDivider = Container(
      margin: const EdgeInsetsDirectional.only(start: 62.0),
      color: dividerColor,
      height: dividerHeight,
    );

    // We construct childrenWithDividers as follows:
    // Insert a short divider between all rows.
    // If it is a `_CupertinoTableSectionType.leaded` type,
    // add a long divider for `_CupertinoTableSectionType.plain` type
    assert(children.isNotEmpty);

    final List<Widget> childrenWithDividers = <Widget>[];

    for (var i = 0; i < children.length; i++) {
      var widget = children[i];
      childrenWithDividers.add(widget);
      if (i < children.length - 1) {
        childrenWithDividers.add(_type == _CupertinoTableSectionType.leaded
            ? shortDivider
            : longDivider);
      }
    }

    final DecoratedBox decoratedChildrenGroup = DecoratedBox(
      decoration: BoxDecoration(
        color: CupertinoDynamicColor.resolve(
          CupertinoColors.secondarySystemGroupedBackground,
          context,
        ),
        borderRadius: _kDefaultInsetGroupedBorderRadius,
      ),
      child: Column(
        children: childrenWithDividers,
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: CupertinoDynamicColor.resolve(backgroundColor, context),
      ),
      child: Column(
        children: <Widget>[
          if (header != null)
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: 13.0,
                  color: CupertinoColors.secondaryLabel.resolveFrom(context),
                ),
                child: Padding(
                  padding: _kDefaultHeaderMargin,
                  child: header,
                ),
              ),
            ),
          Padding(
            padding: margin,
            child: ClipRRect(
              borderRadius: _kDefaultInsetGroupedBorderRadius,
              clipBehavior: clipBehavior,
              child: decoratedChildrenGroup,
            ),
          ),
          if (footer != null)
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: 13.0,
                  color: CupertinoColors.secondaryLabel.resolveFrom(context),
                ),
                child: Padding(
                  padding: _kDefaultFooterMargin,
                  child: footer,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
