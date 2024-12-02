import 'package:flutter/material.dart';
import 'package:front_end/Classes/restaurante.dart';
import 'package:front_end/DAO/restaurantes.dart';
import 'package:front_end/Telas/busca.dart';
import 'package:front_end/Telas/detalhes_restaurante.dart';
import 'package:front_end/Telas/restaurantes.dart';
import 'package:front_end/Utils/global_resources.dart';
import 'package:front_end/Utils/result.dart';
import 'package:front_end/Widgets/tile_restaurante.dart';
import 'package:front_end/Widgets/transition.dart';
import 'package:front_end/main.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Widget telaSelecionada = Restaurantes();
  static int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    switch (selectedIndex) {
      case 0:
        {
          // telaSelecionada = Restaurantes();
          telaSelecionada = Restaurantes();
        }
        break;

      case 1:
        {
          //telaSelecionada = Buscador();
          telaSelecionada = Buscador();
        }
        break;

      case 2:
        {
          //TODO: Tela de ajustes/perfil não implementada por não estar no escopo: fallback para Buscador:

          selectedIndex = 1;
          //telaSelecionada = Buscador();
        }
    }

    return MaterialApp(
        //theme: Resources.themeData,
        home: Scaffold(
            appBar: AppBar(
              toolbarHeight: 35,
              title: Row(
                children: [
                  Text(
                    "foo",
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  ),
                  Text(
                    "direto",
                    style: TextStyle(color: Colors.green, fontSize: 30),
                  )
                ],
              ),
            ),
            body: Container(
                decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                //color: Colors.green,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: telaSelecionada,
                    ),
                    /*
                    NavigationRail(
                      groupAlignment: 0.0,
                      //extended: true,
                      minExtendedWidth: 125,

                      //backgroundColor: Colors.black,
                      selectedIndex: selectedIndex,
                      onDestinationSelected: (int index) {
                        //selectedIndex = index;

                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      labelType: NavigationRailLabelType.all,
                      destinations: [
                        NavigationRailDestination(
                            icon: Icon(Icons.restaurant),
                            label: Text("Restaurantes")),
                        NavigationRailDestination(
                            icon: Icon(Icons.search), label: Text("Buscar")),
                        NavigationRailDestination(
                            icon: Icon(Icons.settings), label: Text("Ajustes")),
                      ],
                    ),
                    */
                  ],
                ))));
  }
}
