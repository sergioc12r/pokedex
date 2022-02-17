import 'dart:async';

import 'package:pokedex/src/bloc/bloc.dart';
import 'package:pokedex/src/models/models.dart';
import 'package:pokedex/src/repository/interface_repository.dart';
import 'package:pokedex/src/repository/repository.dart';

class PokemonCardBloc extends Bloc{

  PokemonCardBloc({this.pokemon});

  Pokemon? pokemon;

  final IRepository _repository = Repository();

  final StreamController<Pokemon> _pokemonController = StreamController<Pokemon>();

  Stream<Pokemon?> getPokemonData() async*{
    if(!_needSearchData()){
      yield pokemon;
      return;
    }
    Pokemon response = await _repository.getPokemonDetail(name: pokemon?.name ?? '');
    pokemon = response;
    yield response;
  }

  @override
  close() {
    _pokemonController.close();
  }

  bool _needSearchData(){
    if(pokemon == null) return true;
    if(pokemon?.imageUrl == null) return true;
    return false;
  }

}