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
  //List<String> items = List<String>.generate(2, (i) => 'Item $i');

  /*
  return ListView.separated(
      itemBuilder: (context, index) {
        return Text(index.toString());
      },
      separatorBuilder: (context, index) => VerticalDivider(),
      itemCount: 5);
  */

  /*
  return ListView.builder(
    itemCount: items.length,
    prototypeItem: ListTile(
      title: Text(items.first),
    ),
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(items[index]),
      );
    },
  );
  */

  List<Restaurante> restaurantesEncontrados =
      RepositorioRestaurantes().getRestaurantes();

  return ListView.builder(
      shrinkWrap: true,
      itemCount: restaurantesEncontrados.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: Card(
            child: Text("${restaurantesEncontrados[index].nome}"),
          ),
          onTap: () {
            print(
                "Buscar cardápio do restaurante ${restaurantesEncontrados[index].id}");

            Navigator.of(context)
                .push(DefaultRouteTransition(DetalhesRestaurante(
              idRestaurante: restaurantesEncontrados[index].id,
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
          return Center(child: montarListaRestaurantes());
        }

        /// handles others as you did on question
        else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}

class _ListaRestaurantesState extends State<ListaRestaurantes> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Column(
      children: [
        SearchBar(
          onChanged: (value) {
            //print(value);
            RepositorioRestaurantes.campoBusca = value;

            setState(() {});
          },
        ),
        Expanded(
          child: buscadorRestaurantes(),
        )
      ],
    )));
  }
}

//buscadorRestaurantes()
