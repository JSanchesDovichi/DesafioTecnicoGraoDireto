import 'package:flutter/material.dart';

class DetalhesRestaurante extends StatefulWidget {
  const DetalhesRestaurante({super.key});

  @override
  State<DetalhesRestaurante> createState() => _DetalhesRestauranteState();
}

class _DetalhesRestauranteState extends State<DetalhesRestaurante> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: CircularProgressIndicator()));
  }
}
