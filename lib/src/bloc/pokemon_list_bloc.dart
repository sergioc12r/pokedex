import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex/src/bloc/bloc.dart';
import 'package:pokedex/src/models/models.dart';
import 'package:pokedex/src/repository/interface_repository.dart';
import 'package:pokedex/src/repository/repository.dart';

class PokemonListBloc extends Bloc{

  List<Pokemon> _pokemons =[];

  int page = 1;

  final IRepository _repository = Repository();

  Stream<List<Pokemon>> getPokemons() async*{
    yield _pokemons;
    print("perri hola $page");
    _scrollUtilsController.add(ScrollUtils(hasReachedMax: false, isLoading: true));
    PokeResponse _response = await _repository.getPokemonList(page: page);
    _pokemons.addAll(_response.pokemons ?? []);
    yield _pokemons;
    _scrollUtilsController.add(ScrollUtils(hasReachedMax: _response.nextUrl == null, isLoading: false));
  }
  
  StreamController<List<Pokemon>> _controller = new StreamController<List<Pokemon>>();
  
  StreamController<ScrollUtils> _scrollUtilsController = new StreamController<ScrollUtils>();
  
  Stream<ScrollUtils> get scrollUtils => _scrollUtilsController.stream;

  void getNextPage(){
    page++;
    _scrollUtilsController.add(ScrollUtils(hasReachedMax: false, isLoading: true));
    getPokemons().listen((event) {
      _controller.add(event);
    });
  }

  @override
  close() {
    _scrollUtilsController.close();
    _controller.close();
  }



}