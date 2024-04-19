import 'package:fc_common/fc_common.dart';
import 'package:fc_domain/fc_domain.dart';
import 'package:flut_cast/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';

part 'search_provider.freezed.dart';
part 'search_state.dart';

final search = StateNotifierProvider<SearchProvider, SearchState>(
  (ref) => SearchProvider(
    const SearchState.initial(),
    searchRepository: ref.read(Repositories.search),
  ),
);

class SearchProvider extends StateNotifier<SearchState> {
  SearchProvider(
    super.state, {
    required ISearchRepository searchRepository,
  }) : _searchRepository = searchRepository;
  final ISearchRepository _searchRepository;

  Future<void> search(String query) async {
    if (query.isEmpty) {
      state = const SearchState.initial();
      return;
    }
    state = const SearchState.searching();
    final result = await _searchRepository.search(
      request: SearchRequest(query: query),
    );
    state = switch (result) {
      Right(value: final cities) => SearchState.searched(
          cities: cities,
          query: query,
        ),
      Left(value: final failure) => SearchState.error(failure: failure),
    };
  }
}
