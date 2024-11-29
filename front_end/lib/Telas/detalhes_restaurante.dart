import 'package:flutter/material.dart';
import 'package:front_end/Classes/item_cardapio.dart';
import 'package:front_end/DAO/restaurantes.dart';
import 'package:front_end/Widgets/transition.dart';

/*
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
*/

class DetalhesRestaurante extends StatefulWidget {
  const DetalhesRestaurante({super.key, required this.idRestaurante});

  final int idRestaurante;

  @override
  State<DetalhesRestaurante> createState() => _DetalhesRestauranteState();
}

String? caixaPesquisa;

Widget montarListaRestaurantes() {
  return ListView.builder(
      itemCount: RepositorioCardapio.listaItens.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: Card(
            child: Text("${RepositorioCardapio.listaItens[index].nome}"),
          ),
          /*
          onTap: () {
            print(
                "Buscar cardápio do restaurante ${RepositorioCardapio.listaItens[index].id}");


            Navigator.of(context)
                .push(DefaultRouteTransition(DetalhesRestaurante()));
          },
          */
        );

        /*
        return Card(
            child: Icon(
          Icons.ac_unit_sharp,
          color: Colors.red,
        ));
        */
      });
}

Widget buscadorRestaurantes(int idRestaurante) {
  return FutureBuilder(
      future: RestauranteDAO().buscarCardapio(idRestaurante),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return montarListaRestaurantes();
        }

        /// handles others as you did on question
        else {
          return CircularProgressIndicator();
        }
      });
}

class _DetalhesRestauranteState extends State<DetalhesRestaurante> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: buscadorRestaurantes(widget.idRestaurante),
    ));
  }
}
