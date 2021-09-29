part of 'local_albums_bloc.dart';

abstract class LocalAlbumsEvent extends Equatable {
  const LocalAlbumsEvent();
}

class LocalAlbumsEventRefresh extends LocalAlbumsEvent {
  @override
  List<Object?> get props => [];
}
