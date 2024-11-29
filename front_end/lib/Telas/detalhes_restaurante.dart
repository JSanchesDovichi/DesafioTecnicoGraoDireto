import 'package:flutter/material.dart';
import 'package:front_end/Classes/item_cardapio.dart';
import 'package:front_end/DAO/restaurantes.dart';
import 'package:front_end/Utils/global_resources.dart';
import 'package:front_end/Widgets/transition.dart';

class DetalhesRestaurante extends StatefulWidget {
  const DetalhesRestaurante({super.key, required this.idRestaurante});

  final int idRestaurante;

  @override
  State<DetalhesRestaurante> createState() => _DetalhesRestauranteState();
}

Widget montarListaCardapio() {
  List<ItemCardapio> cardapioEncontrado = RepositorioCardapio().getCardapio();

  return ListView.builder(
      shrinkWrap: true,
      itemCount: cardapioEncontrado.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: Card(
            child: Text("${cardapioEncontrado[index].nome}"),
          ),
          onTap: () {
            /*
            Navigator.of(context)
                .push(DefaultRouteTransition(DetalhesRestaurante(
              idRestaurante: cardapioEncontrado[index].id,
            )));
            */
          },
        );
      });
}

Widget buscadorCardapio(int idRestaurante) {
  return FutureBuilder(
      future: RestauranteDAO().buscarCardapio(idRestaurante),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return Center(child: montarListaCardapio());
        }

        /// handles others as you did on question
        else {
          return Center(child: CircularProgressIndicator());
        }
      });
}

class _DetalhesRestauranteState extends State<DetalhesRestaurante> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //theme: Resources.themeData,
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back)),
            ),
            body: Column(
              children: [
                SearchBar(
                  onChanged: (value) {
                    //print(value);
                    RepositorioCardapio.campoBusca = value;

                    setState(() {});
                  },
                ),
                Expanded(
                  child: buscadorCardapio(widget.idRestaurante),
                )
              ],
            )));
  }
}
