import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lastfm/models/album.dart';
import 'package:lastfm/models/albums.dart';
import 'package:lastfm/presentation/bloc/local_albums/local_albums_bloc.dart';
import 'package:lastfm/repositories/offline_repository.dart';
import 'package:lastfm/utils/error/failures.dart';
import 'package:lastfm/utils/local_albums/local_albums.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final OfflineRepository offlineRepository;
  final LocalAlbums albumsSingleton = LocalAlbums();
  HomeBloc({required this.offlineRepository}) : super(HomeInitial()){
    print('bla');
    albumsSingleton.addListener(() { 
      add(HomeEventRefresh());
    });
  }

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeEventGetAlbums) {
      yield* mapGetEventToState(event);
    } else if (event is HomeEventRefresh) {
      yield HomeComplete(albumsSingleton.albums);
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
      albumsSingleton.refreshAlbum(albums);
      print("got albums $albums");
    });
  }
}
