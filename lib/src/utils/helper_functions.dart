import 'package:flutter/material.dart';

class HelperFunctions{

  static String capitalize(String s){
    if(s.isEmpty) return s;
    if(s.length == 1) return s.toUpperCase();
    try{
      return s[0].toUpperCase() + s.substring(1).toLowerCase();
    }catch(e){
      return s;
    }
  }

  static Color? colorTypeByName(String name){
    switch (name){
      case 'normal':
        return const Color(0xFFA7A877);
      case 'fire':
        return const Color(0xFFF08130);
      case 'fighting':
        return const Color(0xFFC13128);
      case 'water':
        return const Color(0xFF6790F0);
      case 'flying':
        return const Color(0xFFA890F0);
      case 'grass':
        return const Color(0xFF78C84F);
      case 'poison':
        return const Color(0xFF9F409F);
      case 'electric':
        return const Color(0xFFF9CF30);
      case 'ground':
        return const Color(0xFFE1C068);
      case 'psychic':
        return const Color(0xFFF95887);
      case 'rock':
        return const Color(0xFFB9A038);
      case 'ice':
        return const Color(0xFF99D7D8);
      case 'bug':
        return const Color(0xFFA9B720);
      case 'dragon':
        return const Color(0xFF7038F8);
      case 'ghost':
        return const Color(0xFF705898);
      case 'dark':
        return const Color(0xFF6F5848);
      case 'steel':
        return const Color(0xFFB8B9D0);
      case 'fairy':
        return const Color(0xFFEE99AC);
      case '???':
        return const Color(0xFF68A090);
      default:
        return Colors.black;
    }
  }
}