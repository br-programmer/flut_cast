import 'package:fc_common/fc_common.dart';
import 'package:fc_domain/fc_domain.dart';

abstract interface class IForecastRepository {
  FutureHttpRequest<Forecast> forescast({required ForecastRequest request});
}
