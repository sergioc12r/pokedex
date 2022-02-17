import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/src/bloc/pokemon_card_bloc.dart';
import 'package:pokedex/src/models/models.dart';
import 'package:pokedex/src/screens/common/element_card.dart';
import 'package:pokedex/src/utils/helper_functions.dart';

class PokemonCard extends StatefulWidget{

  final Pokemon? pokemon;

  const PokemonCard({Key? key, this.pokemon}) : super(key: key);

  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {

  PokemonCardBloc? _pokemonBloc;
  Pokemon? _pokemonActual;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return StreamBuilder(
        stream: _pokemonBloc?.getPokemonData(),
        builder: (context,AsyncSnapshot<Pokemon?> snapshot){
          if(snapshot.hasError) return const Text('Error perri');
          if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          _pokemonActual = snapshot.data;
          return _pokeCard();
          },
      );
    });
  }

  onTapCard() => Navigator.pushNamed(context, '/detail', arguments: _pokemonActual);

  Widget _pokeCard(){
    return GestureDetector(
      onTap: onTapCard,
      child: AbsorbPointer(
        absorbing: true,
        child: Stack(
          children: [
            _fontColorFilter(),
            _fontBlackFilter(),
            _pokemonFont(),
            _principalData(),
            _secondaryData(),
          ],
        ),
      ),
    );
  }
  
  Widget _fontBlackFilter(){
    return Row(
      children: [
        Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: const [Expanded(child: SizedBox())],
              ),
            )
        ),
      ],
    );
  }

  Widget _fontColorFilter(){
    List<Color> colors = [];
    _pokemonActual?.types?.forEach((element) => colors.add(element.color?.withOpacity(0.7) ?? Colors.red));
    BoxDecoration decoration = colors.length == 1 ?
    BoxDecoration(color: colors.first, borderRadius: BorderRadius.circular(20)) :
    BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: colors,
      ),
    );
    return Row(
      children: [
        Expanded(
            child: Container(
              decoration: decoration,
              child: Column(
                children: const[ Expanded(child: SizedBox())],
              ),
            )
        ),
      ],
    );
  }

  Widget _pokemonFont(){
    return Positioned(
        right: -50,
        top: -5,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.4) ,borderRadius: BorderRadius.circular(200)),
        )
    );
  }

  Widget _principalData(){
    return Row(
      children: [
        Expanded(
            flex: 6,
            child: _titleCard()
        ),
        const Expanded(flex: 4,child: SizedBox())
      ],
    );
  }

  Widget _secondaryData(){
    return Row(
      children: [
        const Expanded(flex: 6,child: SizedBox()),
        Expanded(flex: 4,child: _imageWidget())
      ],
    );
  }

  Widget _imageWidget(){
    return SizedBox(
      child: Hero(
        tag: _pokemonActual?.name ?? " ",
        child: SvgPicture.network(
          _pokemonActual?.imageUrl ?? "",
          fit: BoxFit.contain,
          placeholderBuilder: (BuildContext context) => const Center(
              child: CircularProgressIndicator())
        ),
      ),
    );
  }

  Widget _titleCard(){
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 10),
      child: Column(
        children: [
          const Expanded(flex: 1, child: SizedBox()),
          Expanded(flex: 2 ,child: _nameWidget()),
          Expanded(flex: 2 ,child: _typesList()),
          const Expanded(flex: 1, child: SizedBox()),
        ],
      ),
    );
  }

  Widget _nameWidget(){
    return Row(
      children: [
        Expanded(child:
          Text(
            HelperFunctions.capitalize(_pokemonActual?.name ?? ''),
            style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold ,
            color: Colors.white),
            textAlign: TextAlign.center,
        )),
        const SizedBox(width: 10),
        Text('#${_pokemonActual?.id ?? 1}', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold ,color: Colors.white)),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _typesList(){
    return Row(
      children: [
        const Text('Type: ', style: TextStyle(fontSize: 15, color: Colors.white)),
        Expanded(
          child: Wrap(
            spacing: 2,
            runSpacing: 2,
            direction: Axis.horizontal,
            children: _pokemonActual?.types?.map((e) => _elementCard(e)).toList() ?? [],
          ),
        ),
      ],
    );
  }

  Widget _elementCard(PokeType pokeType) => ElementCard(pokeType: pokeType);

  @override
  void initState() {
    _pokemonBloc = PokemonCardBloc(pokemon: widget.pokemon);
    super.initState();
  }

  @override
  void dispose() {
    _pokemonBloc?.close();
    super.dispose();
  }
}
