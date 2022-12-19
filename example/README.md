# cupertino_tables

Demonstrates how to use the [cupertino_tables package][1]

[1]: ../


```dart
import 'package:cupertino_tables/cupertino_table_row.dart';
import 'package:cupertino_tables/cupertino_table_section.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Cupertino Tables Demo"),
        ),
        child: Container(
          padding: const EdgeInsets.only(top: 22.0),
          color: CupertinoColors.systemGroupedBackground,
          child: SafeArea(
            top: true,
            child: Column(
              children: [
                _buildAlbumsSection(),
                _buildSettingsSection(),
                _buildSimpleSection(),
              ],
            ),
          ),
        ));
  }

  Widget _buildAlbumsSection() {
    return CupertinoTableSection(
      header: const Text("ALBUMS"),
      children: [
        CupertinoTableRow(
          title: const Text("Immortal Flame"),
          helper: const Text("The never ending life"),
          leading: const CupertinoTableRowIcon(
            backgroundColor: CupertinoColors.systemRed,
            icon: CupertinoIcons.flame,
          ),
          trailing: const CupertinoTableRowNavigationIndicator(),
          onPress: () {
            // do something on press
          },
        ),
        CupertinoTableRow(
          title: const Text("Happy Clouds"),
          helper: const Text("High in the sky"),
          leading: const CupertinoTableRowIcon(
            backgroundColor: CupertinoColors.activeBlue,
            icon: CupertinoIcons.cloud,
          ),
          trailing: const CupertinoTableRowNavigationIndicator(),
          onPress: () {
            // do something on press
          },
        )
      ],
    );
  }

  Widget _buildSettingsSection() {
    return CupertinoTableSection(
      header: const Text("SETTINGS"),
      children: [
        CupertinoTableRow(
          title: const Text("Dark Mode"),
          leading: const CupertinoTableRowIcon(
            icon: CupertinoIcons.moon_stars,
          ),
          trailing: const CupertinoTableRowNavigationIndicator(),
          onPress: () {
            // do something on press
          },
        ),
        CupertinoTableRow(
          title: const Text("Card"),
          leading: const CupertinoTableRowIcon(
            backgroundColor: CupertinoColors.activeGreen,
            icon: CupertinoIcons.cart,
          ),
          trailing: const CupertinoTableRowNavigationIndicator(),
          onPress: () {
            // do something on press
          },
        ),
      ],
    );
  }

  Widget _buildSimpleSection() {
    return CupertinoTableSection(
      header: const Text("SIMPLE LIST"),
      footer: const Text("Copyright © 2022 AndroDevelopment"),
      children: [
        const CupertinoTableRow(
          title: Text("Some Information"),
        ),
        const CupertinoTableRow(
          title: Text("Star walking"),
          leading: Icon(
            CupertinoIcons.star,
            color: CupertinoColors.systemPurple,
          ),
        ),
        CupertinoTableRow(
          title: const Text("Turn me ON"),
          leading: const Icon(
            CupertinoIcons.lightbulb_fill,
            color: CupertinoColors.systemYellow,
          ),
          trailing: CupertinoSwitch(
            value: true,
            onChanged: (value) {
              // do something on switch
            },
          ),
        ),
      ],
    );
  }
}

```