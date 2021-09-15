part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String msg;

  HomeError(this.msg);
  @override
  List<Object> get props => [msg];
}

class HomeComplete extends HomeState {
  final Albums albums;

  HomeComplete(this.albums);
  @override
  List<Object> get props => [albums];
}
