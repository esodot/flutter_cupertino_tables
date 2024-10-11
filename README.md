![example workflow](https://github.com/esodot/flutter_cupertino_tables/actions/workflows/flutter.yml/badge.svg)

![In-App Review iOS Demo](https://github.com/esodot/flutter_cupertino_tables/blob/master/screenshots/example.png?raw=true)

Flutter package providing cupertino table section and cupertino table row.

## Features

- Configurable easy to use Cupertino iOS like table section and table rows

## Installation

Run `flutter pub add cupertino_tables`

Run `flutter pub get`

## Usage

Import packages

```dart
import 'package:cupertino_tables/cupertino_table_section.dart';
import 'package:cupertino_tables/cupertino_table_row.dart';

// Use default constructor `CupertinoTableSection` to implement long dividers between rows.
CupertinoTableSection(children: []);

// Use named constructor `CupertinoTableSection.leaded` to implement short dividers between rows, 
// as leading widget will be considers
CupertinoTableSection.leaded(children: []);
```

## Additional information

Check example how to use [example](example/README.md)

## Contribution

You are very welcome to contribute to the package:

- Fork the Repo
- Add your changes (don't forget to add tests as well)
- Create a Pull Request (PR)

We will check your input asap

## Publisher

Created by AndroDevs @2022

Follow us on Twitter [AndroDevs](https://twitter.com/AndroDevs)

## Disclaimer

Support for this library is given as _best effort_.

This library has not been reviewed or vetted by security professionals.
