import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lastfm/models/albums.dart';
import 'package:lastfm/repositories/lastfm_repository.dart';
import 'package:lastfm/utils/error/failures.dart';

part 'artist_top_albums_event.dart';
part 'artist_top_albums_state.dart';

class ArtistTopAlbumsBloc
    extends Bloc<ArtistTopAlbumsEvent, ArtistTopAlbumsState> {
  final LastfmRepository lastfmRepository;
  ArtistTopAlbumsBloc({required this.lastfmRepository})
      : super(ArtistTopAlbumsInitial());

  @override
  Stream<ArtistTopAlbumsState> mapEventToState(
    ArtistTopAlbumsEvent event,
  ) async* {
    if (event is ArtistTopAlbumsEventGet) {
      yield* mapGetEventToState(event);
    }
  }

  @override
  Stream<ArtistTopAlbumsState> mapGetEventToState(
    ArtistTopAlbumsEventGet event,
  ) async* {
    yield ArtistTopAlbumsLoading();
    final res = await lastfmRepository.getTopAlbumsOfArtist(event.artistName);
    yield* res.fold((Failure failure) async* {
      yield ArtistTopAlbumsError(failure.msg);
    }, (Albums albums) async* {
      yield ArtistTopAlbumsComplete(albums);
    });
  }
}
