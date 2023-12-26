
# Flutter Spinner Item Selector

A Flutter package providing a simple way for define a spinner item selector. The package will works for any provided list of items with optional types. for example, you can provide list of widgets, enums or any other objects.

[![pub](https://img.shields.io/pub/v/flutter_spinner_item_selector.svg)](https://pub.dev/packages/flutter_spinner_item_selector)
[![license: MIT](https://img.shields.io/badge/license-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Flutter package providing custom item selector widgets for easy item selection in your Flutter applications.

## Preview

### Dark Mode



## Light Mode



## Installation

Add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_spinner_item_selector: [latest]
```

## Usage

Import the package:

```dart
import 'package:flutter_spinner_item_selector/flutter_spinner_item_selector.dart';
```

### How to use

Example usage:

```dart
Icon? selectedItem;

void _showItemSelector() async {
    final selected = await showSpinnerItemSelector<Icon>(
        context,
        items: const [
            Icon(Icons.home),
            Icon(Icons.back_hand),
            Icon(Icons.face),
            Icon(Icons.bluetooth),
            Icon(Icons.bolt_outlined),
            Icon(Icons.read_more),
        ],
        selectedItemToWidget: (item) => item,
        nonSelectedItemToWidget: (item) => Opacity(opacity: 0.4, child: item as Icon),
        itemHeight: 50,
        height: 150,
        width: 100,
        spinnerHeight: 140,
        spinnerWidth: 90,
    );

    if (selected != null) {
        setState(() {
        selectedItem = selected;
        });
    }
}
```


## Fully customizable package

```dart
import 'package:flutter/material.dart';
import 'package:flutter_spinner_item_selector/flutter_spinner_item_selector.dart';

// --------
showSpinnerItemSelector(
    context,
    items: const [
        Icon(Icons.home),
        Icon(Icons.back_hand),
        Icon(Icons.face),
        Icon(Icons.bluetooth),
        Icon(Icons.bolt_outlined),
        Icon(Icons.read_more),
    ],
    selectedItemToWidget: (item) => item,
    nonSelectedItemToWidget: (item) => Opacity(opacity: 0.4, child: item as Icon),
    itemHeight: 50,
    height: 150,
    width: 100,
    spinnerHeight: 140,
    spinnerWidth: 90,
    title: 'Custom Item Selector',
    backgroundColor: Colors.grey[100],
    foregroundColor: Colors.black,
    titleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    buttonStyle: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
    ),
    buttonTextStyle: TextStyle(fontSize: 16, color: Colors.white),
    barrierDismissible: true,
    // ... other customization options
);

```


## Complete Example

Here's a simple example of how to use the custom item selector widgets:


```dart
import 'package:flutter/material.dart';
import 'package:flutter_spinner_item_selector/flutter_spinner_item_selector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Item Selector Example',
      darkTheme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Icon? selectedItem;

  void _showItemSelector() async {
    final selected = await showSpinnerItemSelector<Icon>(
      context,
      items: const [
        Icon(Icons.home),
        Icon(Icons.back_hand),
        Icon(Icons.face),
        Icon(Icons.bluetooth),
        Icon(Icons.bolt_outlined),
        Icon(Icons.read_more),
      ],
      selectedItemToWidget: (item) => item,
      nonSelectedItemToWidget: (item) => Opacity(opacity: 0.4, child: item as Icon),
      itemHeight: 50,
      height: 150,
      width: 100,
      spinnerHeight: 140,
      spinnerWidth: 90,
    );

    if (selected != null) {
      setState(() {
        selectedItem = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Selector Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Selected Item:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            selectedItem != null ? selectedItem! : const Text('. . .'),
            const SizedBox(height: 20),
            FilledButton(onPressed: _showItemSelector, child: const Text('Select an Item')),
          ],
        ),
      ),
    );
  }
}
```


## Direct using of `SpinnerItemSelector`
You can also use directly `SpinnerItemSelector` widget in your app

```dart
import 'package:flutter/material.dart';
import 'package:flutter_spinner_item_selector/flutter_spinner_item_selector.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text("text"),
          // using `SpinnerItemSelector`
          SpinnerItemSelector<Widget>(
            // providing list of items
            items: const [
                ListTile(leading: Icon(Icons.home),title: Text("Home")),
                ListTile(leading: Icon(Icons.book),title: Text("Book")),
                ListTile(leading: Icon(Icons.sd_card),title: Text("sdCard")),
            ],
            selectedItemToWidget: (item) => Container(child: items), // map item to widget
            nonSelectedItemToWidget: (item) => Container(child: items), // map item to widget
            onSelectedItemChanged: (item) {
                // handle selected item 
            },
            height: _spinnerHeight,
            width: _spinnerWidth,
            itemHeight: _itemHeight,
            spinnerBgColor: _spinnerBgColor,
          ),
        ],
      ),
    );
  }
}
```

For more customization options and advanced usage, refer to the [API documentation](#).

## License

This package is released under the [MIT License](LICENSE).
