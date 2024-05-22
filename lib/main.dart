import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const AgeTimerApp());
}

class AgeTimerApp extends StatelessWidget {
  const AgeTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Timer Motivation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AgeTimerPage(),
    );
  }
}

class AgeTimerPage extends StatefulWidget {
  const AgeTimerPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AgeTimerPageState createState() => _AgeTimerPageState();
}

class _AgeTimerPageState extends State<AgeTimerPage> {
  final DateTime _birthDate =
      DateTime(2002, 1, 1); // Coloca tu fecha de nacimiento aquí
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _startTimer();
  }

  void _startTimer() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _currentTime = DateTime.now();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int age = _calculateAge(_currentTime);
    int hours = _calculatehours(_currentTime);
    int minutes = _calculateMinutes(_currentTime);
    int seconds = _calculateSeconds(_currentTime);
    int days = _calculateDays(_currentTime);

    return Scaffold(
      body: Center(
        child: Text(
          '${formatValue(age)}.${formatValue(days)}${formatValue(hours)}${formatValue(minutes)}${formatValue(seconds)}',
          style: const TextStyle(
              fontSize: 50, color: Color.fromARGB(255, 49, 49, 49)),
        ),
      ),
    );
  }

  int _calculateAge(DateTime currentTime) {
    int age = currentTime.year - _birthDate.year;
    if (currentTime.month < _birthDate.month ||
        (currentTime.month == _birthDate.month &&
            currentTime.day < _birthDate.day)) {
      age--;
    }
    return age;
  }

  int _calculatehours(DateTime currentTime) {
    int hours = currentTime.hour - _birthDate.hour;
    if (currentTime.minute < _birthDate.minute ||
        (currentTime.minute == _birthDate.minute &&
            currentTime.second < _birthDate.second)) {
      hours--;
    }
    return hours;
  }

  int _calculateMinutes(DateTime currentTime) {
    int minutes = currentTime.minute - _birthDate.minute;
    if (currentTime.second < _birthDate.second) {
      minutes--;
    }
    return minutes;
  }

  int _calculateSeconds(DateTime currentTime) {
    int seconds = currentTime.second - _birthDate.second;
    return seconds < 0 ? 60 + seconds : seconds;
  }

  int _calculateDays(DateTime currentTime) {
    int days = currentTime.day - _birthDate.day;
    if (currentTime.hour < _birthDate.hour ||
        (currentTime.hour == _birthDate.hour &&
            currentTime.minute < _birthDate.minute)) {
      days--;
    }
    return days;
  }

  String formatValue(int value) {
    return value < 10 ? '0$value' : value.toString();
  }
}
