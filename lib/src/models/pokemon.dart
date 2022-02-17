import 'package:equatable/equatable.dart';
import 'package:pokedex/src/models/models.dart';

import 'models.dart';

class Pokemon extends Equatable{

  final String? name;
  final String? imageUrl; // sprites - front_default
  final int? height;
  final int? weight;
  final int? baseExperience; //base_experience
  final List<String>? media;
  final bool? isHidden;
  final List<Stats>? stats;
  final List<PokeType>? types;
  final int? id;

  const Pokemon({
    this.name,this.imageUrl,this.height,this.weight,this.baseExperience,
    this.media,this.isHidden,this.stats,this.types,this.id
  });

  @override
  List<Object?> get props => [name,imageUrl,height,weight,baseExperience,media,isHidden,stats,types,id];

  factory Pokemon.fromJson(Map<String,dynamic> json){
    Iterable stats = json['stats'] ?? const Iterable.empty();
    Iterable types = json['types'] ?? const Iterable.empty();
    String? image = json['id'] == null ? null 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/${json['id']}.svg';
    return Pokemon(
      name: json['name'],
      imageUrl: image,
      height: json['height'],
      weight: json['weight'],
      baseExperience: json['base_experience'],
      isHidden: json['is_hidden'] ?? false,
      stats: stats.map((e) => Stats.fromJson(e)).toList(),
      types: types.map((e) => PokeType.fromJson(e)).toList(),
      id: json['id'],
    );
  }

}