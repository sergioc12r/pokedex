import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/src/models/models.dart';
import 'package:pokedex/src/screens/pokemon_card.dart';


Pokemon pokemonMock = Pokemon(
    name: 'bulbasaur',
    imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/25.svg',
    weight: 10,
    id: 1,
    types: [PokeType(name: 'Fyre',slot: 1)],
    height: 20
);

void main(){
  group('PokeCard',(){
    testWidgets('Revision PokeCard', (WidgetTester tester)async{
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: Center(
              child: PokemonCard(
                pokemon: pokemonMock,
              ),
            ),
          ),
        ),
      );
      //tester.pump(Duration(seconds: 10));
      final addField = find.byKey(ValueKey("pokemonKey"));
      expect(find.textContaining(pokemonMock.name ?? " "),findsOneWidget);
    });
  });
}