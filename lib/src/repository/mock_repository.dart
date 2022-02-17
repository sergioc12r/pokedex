

import 'package:pokedex/src/models/models.dart';
import 'package:pokedex/src/repository/interface_repository.dart';

class MockRepository extends IRepository{

  List<int> idPokemons = [1,2,3,4,5,6,7,8,9,10,11];

  @override
  Future getPokemonList({int? page}) async {
    List<Pokemon> _list =[];
    _list = idPokemons.map((e) => const Pokemon(name: 'pikachu')).toList();
    await Future.delayed(const Duration(seconds: 3));
    PokeResponse _response = PokeResponse(pokemons: _list, count: _list.length);
    return _response;
  }

  @override
  Future getPokemonDetail({String? name}) {
    // TODO: implement getPokemonDetail
    throw UnimplementedError();
  }

}