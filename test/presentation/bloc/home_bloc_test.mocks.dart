// Mocks generated by Mockito 5.0.15 from annotations
// in lastfm/test/presentation/bloc/home_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:lastfm/models/album_details.dart' as _i6;
import 'package:lastfm/models/albums.dart' as _i7;
import 'package:lastfm/repositories/offline_repository.dart' as _i3;
import 'package:lastfm/utils/error/failures.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [OfflineRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockOfflineRepository extends _i1.Mock implements _i3.OfflineRepository {
  MockOfflineRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> saveAlbumLocally(
          _i6.AlbumDetails? album) =>
      (super.noSuchMethod(Invocation.method(#saveAlbumLocally, [album]),
              returnValue: Future<_i2.Either<_i5.Failure, bool>>.value(
                  _FakeEither_0<_i5.Failure, bool>()))
          as _i4.Future<_i2.Either<_i5.Failure, bool>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> removeAlbumLocally(
          _i6.AlbumDetails? album) =>
      (super.noSuchMethod(Invocation.method(#removeAlbumLocally, [album]),
              returnValue: Future<_i2.Either<_i5.Failure, bool>>.value(
                  _FakeEither_0<_i5.Failure, bool>()))
          as _i4.Future<_i2.Either<_i5.Failure, bool>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.Albums>> getAlbumsLocally() =>
      (super.noSuchMethod(Invocation.method(#getAlbumsLocally, []),
              returnValue: Future<_i2.Either<_i5.Failure, _i7.Albums>>.value(
                  _FakeEither_0<_i5.Failure, _i7.Albums>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i7.Albums>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.AlbumDetails?>> getAlbumLocally(
          String? artistName, String? albumName) =>
      (super.noSuchMethod(
          Invocation.method(#getAlbumLocally, [artistName, albumName]),
          returnValue: Future<_i2.Either<_i5.Failure, _i6.AlbumDetails?>>.value(
              _FakeEither_0<_i5.Failure, _i6.AlbumDetails?>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i6.AlbumDetails?>>);
  @override
  String toString() => super.toString();
}
