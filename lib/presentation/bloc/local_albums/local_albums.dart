part of 'local_albums_bloc.dart';

abstract class LocalAlbumsState extends Equatable {
  const LocalAlbumsState();
  @override
  List<Object> get props => [];
}

class LocalAlbumsInitial extends LocalAlbumsState {}

class LocalAlbumsRefresh extends LocalAlbumsState {}
