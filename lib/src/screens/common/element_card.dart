import 'package:flutter/material.dart';
import 'package:pokedex/src/models/type.dart';
import 'package:pokedex/src/utils/helper_functions.dart';

class ElementCard extends StatelessWidget{

  final PokeType pokeType;

  const ElementCard({Key? key, required this.pokeType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: pokeType.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(HelperFunctions.capitalize(pokeType.name ?? ''), style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold)),
      ),
    );
  }

}