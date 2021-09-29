import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'local_albums_event.dart';
part 'local_albums.dart';

class LocalAlbumsBloc extends Bloc<LocalAlbumsEvent, LocalAlbumsState> {
  LocalAlbumsBloc() : super(LocalAlbumsInitial());

  @override
  Stream<LocalAlbumsState> mapEventToState(
    LocalAlbumsEvent event,
  ) async* {
    if (event is LocalAlbumsEventRefresh) {
      yield LocalAlbumsRefresh();
    }
  }
}
