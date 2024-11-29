import 'package:flutter/material.dart';
import 'package:front_end/Classes/restaurante.dart';
import 'package:front_end/DAO/restaurantes.dart';
import 'package:front_end/Telas/detalhes_restaurante.dart';
import 'package:front_end/Utils/result.dart';
import 'package:front_end/Widgets/transition.dart';
import 'package:front_end/main.dart';

class ListaRestaurantes extends StatefulWidget {
  const ListaRestaurantes({super.key});

  @override
  State<ListaRestaurantes> createState() => _ListaRestaurantesState();
}

String? caixaPesquisa;

Widget montarListaRestaurantes() {
  return ListView.builder(
      itemCount: RepositorioRestaurantes.listaRestaurantes.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: Card(
            child: Text(
                "${RepositorioRestaurantes.listaRestaurantes[index].nome}"),
          ),
          onTap: () {
            print(
                "Buscar cardápio do restaurante ${RepositorioRestaurantes.listaRestaurantes[index].id}");

            Navigator.of(context)
                .push(DefaultRouteTransition(DetalhesRestaurante(
              idRestaurante:
                  RepositorioRestaurantes.listaRestaurantes[index].id,
            )));
          },
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

Widget buscadorRestaurantes() {
  return FutureBuilder(
      future: RestauranteDAO().buscarRestaurantes(),
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

class _ListaRestaurantesState extends State<ListaRestaurantes> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: buscadorRestaurantes(),
    ));
  }
}
