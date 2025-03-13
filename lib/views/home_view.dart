import 'package:flutter/material.dart';
import 'package:flutterwithgooglemap/views/custom_google_map_app1_view.dart';
import 'package:flutterwithgooglemap/views/route_tracing_app2_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Text('App 1 testing Google Maps'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CustomGoogleMapApp1()),
              );
            },
          ),
          ElevatedButton(
            child: Text('app 2 Route Tracting'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RouteTracingApp2()),
              );
            },
          ),
        ],
      ),
    );
  }
}
