import 'package:flutter/foundation.dart';
import 'package:rx_dart/data/network/api.dart';
import 'package:rx_dart/feature/search_result/rx/search_state.dart';
import 'package:rxdart/rxdart.dart';

@immutable
class SearchRx {
  final Sink<String> search;
  final Stream<SearchState?> state;

  const SearchRx._({required this.search, required this.state});

  factory SearchRx({required Api api}) {
    final textChanges = BehaviorSubject<String>();

    final Stream<SearchState?> results = textChanges
        .distinct()
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap<SearchState?>((String term) {
      if (term.isEmpty) {
        return Stream.value(null);
      } else {
        return Rx.fromCallable(() => api.search(term))
            .delay(const Duration(seconds: 1))
            .map((res) => res.isEmpty
                ? const SearchStatesNoResult()
                : SearchStatesWithResults(res))
            .startWith(const SearchStatesLoading())
            .onErrorReturnWith((error, _) => SearchStatesHasError(error));
      }
    });

    return SearchRx._(search: textChanges.sink, state: results);
  }

  void dispose() {
    search.close();
  }
}
