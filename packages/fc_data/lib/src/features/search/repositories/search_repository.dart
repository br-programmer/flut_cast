import 'package:fc_api_client/fc_api_client.dart';
import 'package:fc_common/fc_common.dart';
import 'package:fc_domain/fc_domain.dart';

class SearchRepository implements ISearchRepository {
  const SearchRepository({required Http http}) : _http = http;
  final Http _http;

  @override
  FutureHttpRequest<List<City>> search({required SearchRequest request}) {
    return performHttpRequest(
      _http.send(
        APIPaths.direct,
        queryParameters: request.toJson(),
        parser: (_, value) => (value as List).mapList((e) => City.fromJson(e)),
      ),
    );
  }

  @override
  FutureHttpRequest<City> reverse({required ReverseRequest request}) {
    return performHttpRequest(
      _http.send(
        APIPaths.reverse,
        queryParameters: request.toJson(),
        parser: (_, value) => City.fromJson((value as List).first),
      ),
    );
  }
}
