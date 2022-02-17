import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/src/models/models.dart';
import 'package:pokedex/src/repository/interface_repository.dart';
  
class Repository extends IRepository{
  final client = http.Client();
  final baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  @override
  Future<PokeResponse?> getPokemonList({int? page})async{
    try {
      int offset = (page ?? 1) * 20 - 20;
      var response = await client.get(Uri.parse('$baseUrl?limit=20&offset=$offset'));
      var parsedJson = jsonDecode(response.body);
      PokeResponse pokeResponse = PokeResponse.fromJson(parsedJson);
      return pokeResponse;
    } catch (e) {
      debugPrint('$e ::::');
      return null;
    }
  }

  @override
  Future getPokemonDetail({String? name}) async{
    try {
      var response = await client.get(Uri.parse('$baseUrl/$name'));
      var parsedJson = jsonDecode(response.body);
      Pokemon pokeResponse = Pokemon.fromJson(parsedJson);
      return pokeResponse;
    } catch (e) {
      debugPrint('$e ::::');
      return null;
    }
  }

}