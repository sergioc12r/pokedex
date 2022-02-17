import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/src/models/models.dart';
import 'package:pokedex/src/repository/mock_repository.dart';
import 'package:pokedex/src/repository/repository.dart';


void main(){

  //BASIC TEST FOR FUNCTIONALITIES
   
  var repository = Repository();

  List<Pokemon> mockPokemon= [
    Pokemon(name: 'pikachu',imageUrl: 'google.com'),
    Pokemon(name: 'raichu', imageUrl: 'google.com'),
  ];
  
  group('Pokemon List Page loads',(){
    test('Page should load a list of products from api',() async{
      await repository.getPokemonList(page: 1);
      expect(mockPokemon.length , 2);
      expect(mockPokemon[0].name, 'pikachu');
      expect(mockPokemon[0].imageUrl, 'google.com');
      expect(mockPokemon[1].name, 'raichu');
      expect(mockPokemon[1].imageUrl, 'google.com');
    });

  });

  
}