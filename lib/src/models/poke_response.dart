import 'package:equatable/equatable.dart';
import 'package:pokedex/src/models/pokemon.dart';
class PokeResponse extends Equatable{
  final String? prevUrl;
  final String? nextUrl;
  final int? count;
  final List<Pokemon>? pokemons;

  const PokeResponse({this.prevUrl, this.nextUrl, this.count, this.pokemons});

  @override
  List<Object?> get props => [prevUrl,nextUrl,count,pokemons];

  factory PokeResponse.fromJson(Map<String,dynamic> json){
    Iterable results = json['results'];
    return PokeResponse(
        prevUrl: json['previous'],
        nextUrl: json['next'],
        count: json['count'],
        pokemons: results.map((pokemon) => Pokemon.fromJson(pokemon)).toList()
    );
  }
}