import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lastfm/models/albums.dart';
import 'package:lastfm/repositories/offline_repository.dart';
import 'package:lastfm/utils/error/failures.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final OfflineRepository offlineRepository;
  HomeBloc({required this.offlineRepository}) : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeEventGetAlbums) {
      yield* mapGetEventToState(event);
    }
  }

  Stream<HomeState> mapGetEventToState(
    HomeEventGetAlbums event,
  ) async* {
    yield HomeLoading();
    final res = await offlineRepository.getAlbumsLocally();
    yield* res.fold((Failure failure) async* {
      yield HomeError(failure.msg);
    }, (Albums albums) async* {
      print("got albums $albums");
      yield HomeComplete(albums);
    });
  }
}
