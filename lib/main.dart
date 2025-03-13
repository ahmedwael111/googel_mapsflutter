import 'package:flutter/material.dart';
import 'package:flutterwithgooglemap/views/home_view.dart';

void main() {
  runApp(const TestGoogleMapsFlutter());
}

class TestGoogleMapsFlutter extends StatelessWidget {
  const TestGoogleMapsFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeView());
  }
}
