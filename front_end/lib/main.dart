import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:front_end/Telas/detalhes_restaurante.dart';
import 'package:front_end/Telas/login.dart';
import 'package:front_end/Telas/restaurantes.dart';
import 'package:front_end/Telas/sandbox.dart';

void main() {
  usePathUrlStrategy();
  runApp(const Driver());
}

/// The main app.
class Driver extends StatelessWidget {
  /// Constructs a [MyApp]
  const Driver({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Login(),
    );
  }
}
