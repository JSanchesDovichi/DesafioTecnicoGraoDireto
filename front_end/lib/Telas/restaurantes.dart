import 'package:flutter/material.dart';
import 'package:front_end/Classes/restaurante.dart';
import 'package:front_end/DAO/restaurantes.dart';
import 'package:front_end/Widgets/tile_restaurante.dart';

class Restaurantes extends StatefulWidget {
  const Restaurantes({super.key});

  @override
  State<Restaurantes> createState() => _RestaurantesState();
}

class _RestaurantesState extends State<Restaurantes> {
  int paginaSelecionada = 1;

  @override
  Widget build(BuildContext context) {
    return buscadorRestaurantes(paginaSelecionada);
  }
}

Widget montarListaRestaurantes(int paginaSelecionada) {
  List<Restaurante> restaurantesEncontrados =
      RepositorioRestaurantes().getRestaurantes();

  List<Widget> tilesRestaurantes = [];

  for (Restaurante restaurante in restaurantesEncontrados) {
    tilesRestaurantes.add(TileRestaurente(
      restaurante: restaurante,
    ));
  }

  return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(children: [
        Text("Restaurantes"),
        Wrap(
          spacing: 12.0, // gap between adjacent chips
          runSpacing: 4.0, // gap between lines

          children: tilesRestaurantes,
        )
      ]));
}

Widget buscadorRestaurantes(int paginaSelecionada) {
  if (RepositorioRestaurantes().getRestaurantes().isNotEmpty) {
    return Center(child: montarListaRestaurantes(paginaSelecionada));
  } else {
    return FutureBuilder(
        future: RestauranteDAO().buscarRestaurantes(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Center(child: montarListaRestaurantes(paginaSelecionada));
          }

          /// handles others as you did on question
          else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
