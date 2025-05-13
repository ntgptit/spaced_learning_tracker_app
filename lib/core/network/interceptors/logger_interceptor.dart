import 'package:dio/dio.dart';
import 'package:slt_app/core/logging/app_logger.dart';

/// Logger interceptor for Dio
/// Logs request and response data
class LoggerInterceptor extends Interceptor {
  final AppLogger _logger;

  LoggerInterceptor(this._logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.info('REQUEST[${options.method}] => PATH: ${options.path}');

    if (options.queryParameters.isNotEmpty) {
      _logger.info('REQUEST PARAMS: ${options.queryParameters}');
    }

    if (options.data != null) {
      _logger.info('REQUEST DATA: ${options.data}');
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.info(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );

    if (response.data != null) {
      _logger.info('RESPONSE DATA: ${response.data}');
    }

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.error(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );

    if (err.response?.data != null) {
      _logger.error('ERROR DATA: ${err.response?.data}');
    }

    return super.onError(err, handler);
  }
}
