import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = 5;
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: Duration(seconds: 2),
              curve: Curves.bounceInOut,
              height: 100,
              decoration: ShapeDecoration(
                gradient: RadialGradient(colors: [Colors.blue, Colors.black]),
                // shape: RoundedRectangleBorder(),
                shape: StarBorder(points: appState.current.toDouble()),
                // shape: CircleBorder(eccentricity: 0.3),
              ),
            ),
          ),
          // ↓ Add this.
          ElevatedButton(
            onPressed: () {
              appState.current += 1;
              appState.notifyListeners();
              print('button pressed!');
            },
            child: Text('Next'),
          ),

          ElevatedButton(
            onPressed: appState.current > 7
                ? () {
                    appState.current -= 5;
                    appState.notifyListeners();
                    print('button pressed!');
                  }
                : null,
            child: Text('Less'),
          ),
          ElevatedButton(
            onPressed: appState.current > 2
                ? () {
                    appState.current -= 1;
                    appState.notifyListeners();
                    print('button pressed!');
                  }
                : null,
            child: Text('Little less'),
          ),
        ],
      ),
    );
  }
}
