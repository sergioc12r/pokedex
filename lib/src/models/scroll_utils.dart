import 'package:equatable/equatable.dart';

class ScrollUtils extends Equatable{

  ScrollUtils({this.isLoading,this.hasReachedMax});

  bool? isLoading;
  bool? hasReachedMax;

  @override
  List<Object?> get props => [isLoading, hasReachedMax];

}