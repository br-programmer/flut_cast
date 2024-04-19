part of 'search_provider.dart';

@freezed
sealed class SearchState with _$SearchState {
  const factory SearchState.initial() = SearchInitialState;
  const factory SearchState.searching() = SearchingState;
  const factory SearchState.searched({
    @Default([]) List<City> cities,
    required String query,
  }) = SearchedState;
  const factory SearchState.error({
    required HttpRequestFailure failure,
  }) = SearchedErrorState;
}
