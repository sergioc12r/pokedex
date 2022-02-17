import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/src/utils/helper_functions.dart';

main(){

  group('Capitalize Test',(){

    test('A lot of words', (){
      String input = "this is a text";
      String output = HelperFunctions.capitalize(input);
      expect(output, "This is a text");
    });

    test('one word', (){
      String input = "pikachu";
      String output = HelperFunctions.capitalize(input);
      expect(output, "Pikachu");
    });

  });

  group('Color Type By Name Test',(){

    test('Type water',(){
      String colorName = 'water';
      Color? colorOutput = HelperFunctions.colorTypeByName(colorName);
      expect(colorOutput,Color(0xFF6790F0));
    });

    test('Type dragon',(){
      String colorName = 'dragon';
      Color? colorOutput = HelperFunctions.colorTypeByName(colorName);
      expect(colorOutput,Color(0xFF7038F8));
    });

  });

}