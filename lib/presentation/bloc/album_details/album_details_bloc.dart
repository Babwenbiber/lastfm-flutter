import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lastfm/models/album_details.dart';
import 'package:lastfm/repositories/lastfm_repository.dart';
import 'package:lastfm/repositories/offline_repository.dart';
import 'package:lastfm/utils/error/failures.dart';
import 'package:lastfm/utils/language/strings.dart';
import 'package:lastfm/utils/shared_preferences/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'album_details_event.dart';
part 'album_details_state.dart';

class AlbumDetailsBloc extends Bloc<AlbumDetailsEvent, AlbumDetailsState> {
  final LastfmRepository lastfmRepository;
  final OfflineRepository offlineRepository;
  final SharedPreferences preferences;
  AlbumDetailsBloc({
    required this.lastfmRepository,
    required this.offlineRepository,
    required this.preferences,
  }) : super(AlbumDetailsInitial());

  @override
  Stream<AlbumDetailsState> mapEventToState(
    AlbumDetailsEvent event,
  ) async* {
    if (event is AlbumDetailsEventGet) {
      final bool isDownloaded =
          isAlbumContained(preferences, event.artistName, event.albumName);
      if (isDownloaded) {
        yield* mapOfflineGetEventToState(event);
      } else {
        yield* mapOnlineGetEventToState(event);
      }
    } else if (event is AlbumDetailsEventSave) {
      yield* mapSaveEventToState(event);
    } else if (event is AlbumDetailsEventRemove) {
      yield* mapRemoveEventToState(event);
    }
  }

  Stream<AlbumDetailsState> mapOnlineGetEventToState(
    AlbumDetailsEventGet event,
  ) async* {
    yield AlbumDetailsLoading();
    final res = await lastfmRepository.getAlbumDetails(
        event.artistName, event.albumName);
    yield* res.fold((Failure failure) async* {
      yield AlbumDetailsError(failure.msg);
    }, (AlbumDetails album) async* {
      yield AlbumDetailsComplete(album, false);
    });
  }

  Stream<AlbumDetailsState> mapOfflineGetEventToState(
    AlbumDetailsEventGet event,
  ) async* {
    yield AlbumDetailsLoading();
    final res = await offlineRepository.getAlbumLocally(
        event.artistName, event.albumName);
    yield* res.fold((Failure failure) async* {
      yield AlbumDetailsError(failure.msg);
    }, (AlbumDetails? album) async* {
      if (album == null) {
        yield AlbumDetailsError(SERVER_TIMEOUT_EXCEPTION_MSG);
      } else {
        yield AlbumDetailsComplete(album, true);
      }
    });
  }

  Stream<AlbumDetailsState> mapSaveEventToState(
    AlbumDetailsEventSave event,
  ) async* {
    final res = await offlineRepository.saveAlbumLocally(event.album);
    yield* res.fold((Failure failure) async* {
      yield AlbumDetailsError(failure.msg);
    }, (_) async* {});
  }

  Stream<AlbumDetailsState> mapRemoveEventToState(
    AlbumDetailsEventRemove event,
  ) async* {
    final res = await offlineRepository.removeAlbumLocally(event.album);
    yield* res.fold((Failure failure) async* {
      yield AlbumDetailsError(failure.msg);
    }, (_) async* {});
  }
}
