import 'package:fc_common/fc_common.dart';
import 'package:fc_domain/fc_domain.dart';

abstract interface class ISearchRepository {
  FutureHttpRequest<List<City>> search({required SearchRequest request});
  FutureHttpRequest<City> reverse({required ReverseRequest request});
}
