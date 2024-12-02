import 'package:flutter/material.dart';
import 'package:front_end/Classes/restaurante.dart';
import 'package:front_end/Telas/detalhes_restaurante.dart';
import 'package:front_end/Utils/global_resources.dart';
import 'package:front_end/Widgets/transition.dart';

const double tileWidth = 150.0;

class TileRestaurente extends StatelessWidget {
  const TileRestaurente({super.key, required this.restaurante});

  final Restaurante restaurante;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(DefaultRouteTransition(CardapioRestaurante(
            idRestaurante: restaurante.id,
          )));
        },
        child: Stack(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                  height: 100.0,
                  width: tileWidth,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 45.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          restaurante.nome!,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          //style: Theme.of(context).textTheme.subhead,
                        ),
                        //Text("bar")
                      ],
                    ),
                  )),
            ),
            Positioned(
              top: .0,
              left: .0,
              right: .0,
              child: Center(
                child: CircleAvatar(
                  radius: 30.0,
                  child: Text("D"),
                ),
              ),
            )
          ],
        ));
  }
}

/*
class TileRestaurente extends StatefulWidget {
  const TileRestaurente({super.key, required this.restaurante});

  final Restaurante restaurante;

  @override
  State<TileRestaurente> createState() => _TileRestaurenteState();
}

class _TileRestaurenteState extends State<TileRestaurente> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Resources.idRestauranteSelecionado = widget.restaurante.id;
          Resources.paginaSelecionada =
              CardapioRestaurante(idRestaurante: widget.restaurante.id);

          Resources.atualizarTelaDashboard();
        },
        child: Stack(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                  height: 100.0,
                  width: 100.0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 45.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.restaurante.nome!,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          //style: Theme.of(context).textTheme.subhead,
                        ),
                        //Text("bar")
                      ],
                    ),
                  )),
            ),
            Positioned(
              top: .0,
              left: .0,
              right: .0,
              child: Center(
                child: CircleAvatar(
                  radius: 30.0,
                  child: Text("D"),
                ),
              ),
            )
          ],
        ));
  }
}
*/