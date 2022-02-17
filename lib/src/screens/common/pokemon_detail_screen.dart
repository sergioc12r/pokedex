import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/src/models/models.dart';
import 'package:pokedex/src/screens/common/element_card.dart';
import 'package:pokedex/src/utils/helper_functions.dart';

class PokemonDetailScreen extends StatelessWidget{

  const PokemonDetailScreen({this.pokemon});

  final Pokemon? pokemon;

  @override
  Widget build(BuildContext context) {

    List<Color> colors = [];
    pokemon?.types?.forEach((element) => colors.add(element.color?.withOpacity(0.7) ?? Colors.red));
    BoxDecoration decoration = colors.length == 1 ?
    BoxDecoration(color: colors.first) :
    BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: colors,
      ),
    );

    return Scaffold(
      body: Container(
        decoration: decoration,
        child: CustomScrollView(
          slivers: [
            _sliverApp(),
            _sliverElements(),
            _sliverPokemonPicture(context),
            _sliverPokemonDetails(),
          ],
        ),
      ),
    );

  }

  Widget _sliverApp(){
    return SliverAppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: Text('${pokemon?.name}'),
    );
  }

  Widget _sliverPokemonPicture(BuildContext context) => SliverToBoxAdapter(child: _imageWidget(context));

  Widget _sliverElements(){
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [

            Expanded(
              child: Wrap(
                spacing: 2,
                runSpacing: 2,
                direction: Axis.horizontal,
                children: pokemon?.types?.map((e) => _elementCard(e)).toList() ?? [],
              ),
            ),
            Text('#${pokemon?.id ?? 0} ',
                style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _elementCard(PokeType pokeType) => ElementCard(pokeType: pokeType);

  Widget _sliverPokemonDetails(){
    return SliverToBoxAdapter(
      child: Card(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }

  Widget _dataItem(){
    return Row(

    );
  }

  Widget _imageWidget(BuildContext context){
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.width * 0.8,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.4) ,borderRadius: BorderRadius.circular(200)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.8,
              child: Hero(
                tag: HelperFunctions.capitalize(pokemon?.name ?? " "),
                child: SvgPicture.network(pokemon?.imageUrl ?? "",
                      fit: BoxFit.contain,
                      placeholderBuilder: (BuildContext context) =>
                          const Center(child: CircularProgressIndicator()))),
            ),
          ],
        ),
      ),
    );
  }
}