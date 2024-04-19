import 'package:fc_common/fc_common.dart';

typedef Json = Map<String, dynamic>;

typedef FutureEither<L, R> = Future<Either<L, R>>;
typedef FutureHttpRequest<R> = Future<Either<HttpRequestFailure, R>>;
