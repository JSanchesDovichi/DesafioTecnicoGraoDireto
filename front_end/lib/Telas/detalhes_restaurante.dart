import 'package:flutter/material.dart';
import 'package:front_end/Classes/item_cardapio.dart';
import 'package:front_end/DAO/restaurantes.dart';
import 'package:front_end/Utils/global_resources.dart';
import 'package:front_end/Widgets/transition.dart';

class CardapioRestaurante extends StatefulWidget {
  const CardapioRestaurante({super.key, required this.idRestaurante});

  final int idRestaurante;

  @override
  State<CardapioRestaurante> createState() => _CardapioRestauranteState();
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

Widget buscadorCardapio(int? idRestaurante) {
  return FutureBuilder(
      future: RestauranteDAO().buscarCardapio(idRestaurante!),
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

class _CardapioRestauranteState extends State<CardapioRestaurante> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ))),
          body: Column(
            children: [
              Expanded(
                child: buscadorCardapio(widget.idRestaurante),
              )
            ],
          )),
    );

    /*
    return Column(

      children: [
        /*
                SearchBar(
                  onChanged: (value) {
                    //print(value);
                    RepositorioCardapio.campoBusca = value;

                    setState(() {});
                  },
                ),
                */
        Expanded(
          child: buscadorCardapio(widget.idRestaurante),
        )
      ],
    );
    */
  }
}
