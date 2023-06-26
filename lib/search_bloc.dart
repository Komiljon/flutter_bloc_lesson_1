import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_event.dart';

part 'search_state.dart';

const apiUrl = 'https://aptechestvo.ru/api/v1/apteki/apteki_list.php';

EventTransformer<E> debounceDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.debounce(duration), mapper);
  };
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState()) {
    on<SearchUserEvent>(
      _onSearch,
      transformer: debounceDroppable(
        const Duration(seconds: 1),
      ),
    );
  }

  final _httpClient = Dio();

  _onSearch(SearchUserEvent event, Emitter<SearchState> emit) async {
    if (event.query.length < 3) return;
    if (event.query == '---') {
      final res = await _httpClient.get(
        apiUrl,
        queryParameters: {
          'query': '',
        },
      );
      emit(SearchState(stores: res.data['offices']));
    } else {
      final res = await _httpClient.get(
        apiUrl,
        queryParameters: {
          'query': event.query,
        },
      );
      emit(SearchState(stores: res.data['offices']));
    }
  }
}
