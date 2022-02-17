import 'package:flutter/material.dart';
import 'package:pokedex/src/bloc/pokemon_list_bloc.dart';
import 'package:pokedex/src/models/models.dart';
import 'package:pokedex/src/screens/pokemon_card.dart';
import 'package:pokedex/src/utils/scroll_mixin.dart';

class HomeScreen extends StatefulWidget{

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with ScrollMixin {

  final PokemonListBloc _pokemonListBloc = PokemonListBloc();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: const Text('PokeSerch'),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: _content(),
      ),
    );
  }

  @override
  void dispose() {
    _pokemonListBloc.close();
    super.dispose();
  }

  _content(){
    return StreamBuilder(
      stream: _pokemonListBloc.getPokemons(),
      builder: (context,AsyncSnapshot<List<Pokemon>> snapshot){
        List<Widget> _slivers = [];
        if(snapshot.hasError){
          _slivers.add(
            const SliverToBoxAdapter(
              child: Text('Error')
            )
          );
          return CustomScrollView(
            slivers: _slivers,
          );
        }
        if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
          _slivers.add( const SliverToBoxAdapter(
            child: CircularProgressIndicator(),
          ));
          return CustomScrollView(
            slivers: _slivers,
          );
        }
        if(snapshot.data?.isEmpty ?? true){
          _slivers.add(const SliverToBoxAdapter(
            child: Text('No data'),
          ));
          return CustomScrollView(
            slivers: _slivers,
          );
        }

        _slivers.add(SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            crossAxisCount: 1,
            childAspectRatio: 2.5,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) =>
                PokemonCard(pokemon: snapshot.data?[index]),
            childCount: snapshot.data?.length ?? 0,
          ),
        ));

        _slivers.add(SliverToBoxAdapter(
          child: Center(
            child: StreamBuilder(
                builder: (context, AsyncSnapshot<ScrollUtils> snapshot) {
                  if (!(snapshot.hasData)) return SizedBox();
                  isLoading = snapshot.data?.isLoading ?? false;
                  hasReachedMax = snapshot.data?.hasReachedMax ?? true;
                  print("perro1 ${snapshot.data}");
                  print("perro2 $isLoading -- $hasReachedMax");
                  print("__________________________________________________");
                  if (isLoading) return CircularProgressIndicator();
                  return SizedBox();
                },
                stream: _pokemonListBloc.scrollUtils),
          ),
        ));

        return CustomScrollView(
          slivers: _slivers,
          controller: controller,
        );
      },
    );
  }

  @override
  onEndOfPage() {
    if(isLoading) return;
    if(hasReachedMax) return;
    _pokemonListBloc.getNextPage();
    isLoading = true;
  }

  @override
  double get scrollThreshold => 20;

}