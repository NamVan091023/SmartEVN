// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://www.hungs20.xyz/v1';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AddressModel?> getWeatherByHour() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddressModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/address',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : AddressModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ParseAddressResponse?> parseAddress({lat, lon}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'lat': lat, r'lng': lon};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ParseAddressResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/address/parse',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : ParseAddressResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<AreaForestModel>?> getAreaForest() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<AreaForestModel>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/iqair/area-forest',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data
        ?.map(
            (dynamic i) => AreaForestModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<IQAirRankVN>?> getRankVN() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<IQAirRankVN>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/iqair',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data
        ?.map((dynamic i) => IQAirRankVN.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<AlertResponse?> getAlerts({page, limit, type, sortBy}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'limit': limit,
      r'type': type,
      r'sortBy': sortBy
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AlertResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/alert',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : AlertResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResponse<dynamic>?> createAlert() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResponse<dynamic>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/alert',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : BaseResponse<dynamic>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<NewsResponse?> getNews({page, limit, type}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'limit': limit,
      r'type': type
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<NewsResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/news',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : NewsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ListDataResponse<PollutionType>?> getPollutionTypes() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListDataResponse<PollutionType>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/pollutions/types',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : ListDataResponse<PollutionType>.fromJson(
            _result.data!,
            (json) => PollutionType.fromJson(json as Map<String, dynamic>),
          );
    return value;
  }

  @override
  Future<ListDataResponse<PollutionQuality>?> getPollutionQualities() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListDataResponse<PollutionQuality>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/pollutions/qualities',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : ListDataResponse<PollutionQuality>.fromJson(
            _result.data!,
            (json) => PollutionQuality.fromJson(json as Map<String, dynamic>),
          );
    return value;
  }

  @override
  Future<DataResponse<PollutionsResponse>?> getAllPollution(
      {type,
      provinceName,
      districtName,
      wardName,
      provinceIds,
      districtIds,
      wardIds,
      status,
      quality,
      searchText,
      userId,
      limit,
      page,
      startDate,
      endDate}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'type': type,
      r'provinceName': provinceName,
      r'districtName': districtName,
      r'wardName': wardName,
      r'provinceIds': provinceIds,
      r'districtIds': districtIds,
      r'wardIds': wardIds,
      r'status': status,
      r'quality': quality,
      r'searchText': searchText,
      r'userId': userId,
      r'limit': limit,
      r'page': page,
      r'startDate': startDate,
      r'endDate': endDate
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<PollutionsResponse>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/pollutions',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : DataResponse<PollutionsResponse>.fromJson(
            _result.data!,
            (json) => PollutionsResponse.fromJson(json as Map<String, dynamic>),
          );
    return value;
  }

  @override
  Future<DataResponse<PollutionsResponse>?> getPollutionAuth(
      {type,
      provinceName,
      districtName,
      wardName,
      status,
      quality,
      limit,
      page,
      sortBy}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'type': type,
      r'provinceName': provinceName,
      r'districtName': districtName,
      r'wardName': wardName,
      r'status': status,
      r'quality': quality,
      r'limit': limit,
      r'page': page,
      r'startDate': sortBy
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<PollutionsResponse>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/pollutions/me',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : DataResponse<PollutionsResponse>.fromJson(
            _result.data!,
            (json) => PollutionsResponse.fromJson(json as Map<String, dynamic>),
          );
    return value;
  }

  @override
  Future<DataResponse<PollutionsResponse>?> getPollutionByUser(
      {userId, limit, page, sortBy}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'userId': userId,
      r'limit': limit,
      r'page': page,
      r'startDate': sortBy
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<PollutionsResponse>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/pollutions/user',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : DataResponse<PollutionsResponse>.fromJson(
            _result.data!,
            (json) => PollutionsResponse.fromJson(json as Map<String, dynamic>),
          );
    return value;
  }

  @override
  Future<DataResponse<PollutionModel>?> getOnePollution({id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<PollutionModel>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/pollutions/$id',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : DataResponse<PollutionModel>.fromJson(
            _result.data!,
            (json) => PollutionModel.fromJson(json as Map<String, dynamic>),
          );
    return value;
  }

  @override
  Future<DataResponse<PollutionModel>?> createPollution({id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<PollutionModel>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/pollutions',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : DataResponse<PollutionModel>.fromJson(
            _result.data!,
            (json) => PollutionModel.fromJson(json as Map<String, dynamic>),
          );
    return value;
  }

  @override
  Future<DataResponse<PollutionModel>?> deletePollution({id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<PollutionModel>>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options, '/pollutions/$id',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : DataResponse<PollutionModel>.fromJson(
            _result.data!,
            (json) => PollutionModel.fromJson(json as Map<String, dynamic>),
          );
    return value;
  }

  @override
  Future<DataResponse<PollutionModel>?> updatePollution({id, images}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<PollutionModel>>(
            Options(method: 'PATCH', headers: _headers, extra: _extra)
                .compose(_dio.options, '/pollutions/$id',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : DataResponse<PollutionModel>.fromJson(
            _result.data!,
            (json) => PollutionModel.fromJson(json as Map<String, dynamic>),
          );
    return value;
  }

  @override
  Future<DataResponse<PollutionStats>?> getPollutionStats() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<PollutionStats>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/pollutions/stats',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : DataResponse<PollutionStats>.fromJson(
            _result.data!,
            (json) => PollutionStats.fromJson(json as Map<String, dynamic>),
          );
    return value;
  }

  @override
  Future<ListDataResponse<PollutionModel>?> getPollutionHistory(
      {districtId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'districtId': districtId};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListDataResponse<PollutionModel>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/pollutions/history',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : ListDataResponse<PollutionModel>.fromJson(
            _result.data!,
            (json) => PollutionModel.fromJson(json as Map<String, dynamic>),
          );
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
