import 'package:flutter/material.dart';

class ServiceDetailScreen extends StatelessWidget {
  final String serviceName;
  final String serviceIcon;

  const ServiceDetailScreen({
    Key? key,
    required this.serviceName,
    required this.serviceIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('ServiceDetailScreen: $serviceName');
    return Scaffold(
      backgroundColor: const Color(0XFF18171C),
      appBar: AppBar(
        title: Text(serviceName),
        backgroundColor: const Color(0xFFA90140),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(serviceIcon, width: 60, height: 60),
              const SizedBox(height: 20),
              Text(
                'You tapped on:',
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                serviceName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  'Go Back',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
