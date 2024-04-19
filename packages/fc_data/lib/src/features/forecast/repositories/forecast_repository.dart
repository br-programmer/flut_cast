import 'package:fc_api_client/fc_api_client.dart';
import 'package:fc_common/src/helpers/typedefs.dart';
import 'package:fc_domain/fc_domain.dart';

class ForecastRepository implements IForecastRepository {
  const ForecastRepository({required Http http}) : _http = http;
  final Http _http;

  @override
  FutureHttpRequest<Forecast> forescast({required ForecastRequest request}) {
    return performHttpRequest(
      _http.send(
        APIPaths.onecall,
        queryParameters: request.toJson(),
        parser: (_, json) => Forecast.fromJson(json),
      ),
    );
  }
}
