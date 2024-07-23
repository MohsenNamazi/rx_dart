import 'package:flutter/foundation.dart';
import 'package:rx_dart/data/models/thing.dart';

@immutable
abstract class SearchState {
  const SearchState();
}

@immutable
class SearchStatesLoading implements SearchState {
  const SearchStatesLoading();
}

@immutable
class SearchStatesNoResult implements SearchState {
  const SearchStatesNoResult();
}

@immutable
class SearchStatesHasError implements SearchState {
  final Object error;
  const SearchStatesHasError(this.error);
}

@immutable
class SearchStatesWithResults implements SearchState {
  final List<Thing> things;
  const SearchStatesWithResults(this.things);
}
