import 'package:equatable/equatable.dart';

class Stats extends Equatable{

  final int? baseStat;
  final String? nameStat;

  const Stats({this.baseStat, this.nameStat});

  @override
  List<Object?> get props => [baseStat,nameStat];

  factory Stats.fromJson(Map<String,dynamic> json){
    return Stats(
      baseStat: json['base_stat'],
      nameStat: json['stat']['name'],
    );
  }

}