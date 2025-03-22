import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Podómetro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int steps = 0;
  int goal = 10000; // Meta predeterminada de pasos

  void _increaseSteps() {
    setState(() {
      steps++;
    });
  }

  void _decreaseSteps() {
    if (steps > 0) {
      setState(() {
        steps--;
      });
    }
  }

  void _setGoal(String value) {
    setState(() {
      goal = int.tryParse(value) ?? goal;
    });
  }

  void _resetSteps() {
    setState(() {
      steps = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = (steps / goal).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(title: Text('Podómetro')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pasos actuales: $steps', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Meta de pasos',
                border: OutlineInputBorder(),
              ),
              onChanged: _setGoal,
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: progress >= 1.0 ? Colors.green : Colors.blue,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _increaseSteps,
                  child: Text('+ Paso'),
                ),
                ElevatedButton(
                  onPressed: _decreaseSteps,
                  child: Text('- Paso'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetSteps,
              child: Text('Reiniciar'),
            ),
          ],
        ),
      ),
    );
  }
}