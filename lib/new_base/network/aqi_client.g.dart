// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aqi_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _AqiClient implements AqiClient {
  _AqiClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.waqi.info';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<WAQIMapResponse?> getAQIMap({networks, token, latlng}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'networks': networks,
      r'token': token,
      r'latlng': latlng
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<WAQIMapResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/v2/map/bounds',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : WAQIMapResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<WAQIIpResponse?> getAQIByIP({token}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'token': token};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<WAQIIpResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/feed/here',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : WAQIIpResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<WAQIIpResponse?> getAQIByGPS({token, lat, lng}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'token': token};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<WAQIIpResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/feed/geo:$lat;$lng',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : WAQIIpResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<WAQIIpResponse?> getAQIById({token, id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'token': token, r'id': id};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<WAQIIpResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/feed/@{id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : WAQIIpResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
