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
        brightness: Brightness.dark,
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
      scrollAxis: Axis.vertical,
      selectedItemToWidget: (item) => item,
      nonSelectedItemToWidget: (item) => Opacity(opacity: 0.4, child: item as Icon),
      itemHeight: 50,
      itemWidth: 50,
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
