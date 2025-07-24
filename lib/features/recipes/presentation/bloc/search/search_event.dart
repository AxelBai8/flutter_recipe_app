import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object> get props => [];
}

class TextChanged extends SearchEvent {
  final String query;
  const TextChanged({required this.query});
}
