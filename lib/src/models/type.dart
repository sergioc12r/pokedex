import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/src/utils/helper_functions.dart';

class PokeType extends Equatable{

  final String? name;
  final int? slot;
  final Color? color;

  const PokeType({this.name, this.slot, this.color});


  @override
  List<Object?> get props => [name,slot,color];

  factory PokeType.fromJson(Map<String,dynamic> json){
    String name = json['type']['name'];
    return PokeType(
      name: name,
      slot: json['slot'],
      color: HelperFunctions.colorTypeByName(name)
    );
  }

}