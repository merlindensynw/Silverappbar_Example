import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SilverAppBar Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'SilverAppBar Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  {

  double get randHeight => Random().nextInt(100).toDouble();

  late List<Widget> _randomChildren;
  List<Widget> _randomHeightWidgets(BuildContext context) {
    _randomChildren = List.generate(3, (index) {
      final height = randHeight.clamp(
        50.0,
        MediaQuery.of(context).size.width,
      );
      return Container(
        color: Colors.primaries[index],
        height: height,
        child: Text('Random Height Child ${index + 1}'),
      );
    });

    return _randomChildren;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Bar'),
        elevation: 0.0,
        centerTitle: false,
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
                  _randomHeightWidgets(context),
                ),
              ),
            ];
          },
          // You tab view goes here
          body: Column(
            children: <Widget>[
              TabBar(
                tabs: [
                  Tab(text: 'A'),
                  Tab(text: 'B'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    GridView.count(
                      padding: EdgeInsets.zero,
                      crossAxisCount: 3,
                      children: Colors.primaries.map((color) {
                        return Container(color: color, height: 150.0);
                      }).toList(),
                    ),
                    ListView(
                      padding: EdgeInsets.zero,
                      children: Colors.primaries.map((color) {
                        return Container(color: color, height: 150.0);
                      }).toList(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


