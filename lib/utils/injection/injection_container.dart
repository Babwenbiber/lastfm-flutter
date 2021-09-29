import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:lastfm/presentation/bloc/album_details/album_details_bloc.dart';
import 'package:lastfm/presentation/bloc/artist_top_albums/artist_top_albums_bloc.dart';
import 'package:lastfm/presentation/bloc/home/home_bloc.dart';
import 'package:lastfm/presentation/bloc/local_albums/local_albums_bloc.dart';
import 'package:lastfm/presentation/bloc/search_artist/search_artist_bloc.dart';
import 'package:lastfm/repositories/lastfm_repository.dart';
import 'package:lastfm/repositories/lastfm_repository_impl.dart';
import 'package:lastfm/repositories/offline_repository.dart';
import 'package:lastfm/repositories/offline_repository_impl.dart';
import 'package:lastfm/usecase/add_to_favourites.dart';
import 'package:lastfm/usecase/remove_from_favourites.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

void initDependencies(
    {isDebug = false, required SharedPreferences preferences}) {
  initCore();
  initExternal(isDebug, preferences);
}

void initCore() {
  sl.registerFactory<HomeBloc>(() => HomeBloc(offlineRepository: sl() ));
  sl.registerFactory(() => SearchArtistBloc(lastfmRepository: sl()));
  sl.registerFactory(() => ArtistTopAlbumsBloc(lastfmRepository: sl()));
  sl.registerFactory(() => AlbumDetailsBloc(
      lastfmRepository: sl(), offlineRepository: sl(), preferences: sl(), removeFromFavorites: sl(), addToFavourites: sl()));

sl.registerLazySingleton(() => LocalAlbumsBloc(
));
  sl.registerLazySingleton(() => AddToFavorites(
        offlineRepository: sl(),
      ));
  sl.registerLazySingleton(() => RemoveFromFavorites(
        offlineRepository: sl(),
      ));
  sl.registerLazySingleton<LastfmRepository>(() => LastfmRepositoryImpl(
        sl(),
      ));
  sl.registerLazySingleton<OfflineRepository>(() => OfflineRepositoryImpl(
        sl(),
      ));
}

void initExternal(isDebug, preferences) {
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<SharedPreferences>(() => preferences);
}
