// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListDataResponse<T> _$ListDataResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ListDataResponse<T>(
      json['status'] as int?,
      json['message'] as String?,
      json['code'] as String?,
      (json['data'] as List<dynamic>?)?.map(fromJsonT).toList(),
      json['totalPages'] as int?,
    );

Map<String, dynamic> _$ListDataResponseToJson<T>(
  ListDataResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'data': instance.data?.map(toJsonT).toList(),
      'totalPages': instance.totalPages,
    };
