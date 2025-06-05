import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter_compass/flutter_compass.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String accel = '...';
  String gyro = '...';
  String compass = '...';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Sensors')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Accelerometer:\n$accel'),
              SizedBox(height: 20),
              Text('Gyroscope:\n$gyro'),
              SizedBox(height: 20),
              Text('Compass:\n$compass'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    final sensors = SensorsPlatform.instance;

    sensors.accelerometerEventStream().listen((event) {
      setState(() {
        accel =
            'X: ${event.x.toStringAsFixed(2)}\n'
            'Y: ${event.y.toStringAsFixed(2)}\n'
            'Z: ${event.z.toStringAsFixed(2)}';
      });
    });

    sensors.gyroscopeEventStream().listen((event) {
      setState(() {
        gyro =
            'X: ${event.x.toStringAsFixed(2)}\n'
            'Y: ${event.y.toStringAsFixed(2)}\n'
            'Z: ${event.z.toStringAsFixed(2)}';
      });
    });

    FlutterCompass.events!.listen((event) {
      setState(() {
        compass = '${event.heading?.toStringAsFixed(1)}°';
      });
    });
  }
}
