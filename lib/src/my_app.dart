import 'package:flutter/material.dart';
import 'package:pokedex/src/screens/common/pokemon_detail_screen.dart';
import 'package:pokedex/src/screens/home_screen.dart';

import 'models/pokemon.dart';

class MyApp extends StatelessWidget{

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serch-Pokedex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xff19e9cf),
        splashColor: const Color(0xff19e9cf)


      ),
      onGenerateRoute: (settings){
          if(settings.name == '/detail'){
            Pokemon pokemon = settings.arguments as Pokemon;
            return MaterialPageRoute(builder: (_) => PokemonDetailScreen(pokemon: pokemon));
          }
      },
      home: HomeScreen(),
    );
  }

}