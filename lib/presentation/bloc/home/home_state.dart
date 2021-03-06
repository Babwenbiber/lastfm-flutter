part of 'home_bloc.dart';

abstract class HomeState  {
  const HomeState();
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String msg;

  HomeError(this.msg);
}

class HomeComplete extends HomeState {
  final Albums albums;

  HomeComplete(this.albums);
}
