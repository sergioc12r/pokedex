abstract class IRepository{

  Future<dynamic> getPokemonList({int? page});

  Future<dynamic> getPokemonDetail({String? name});

}