import 'package:json_annotation/json_annotation.dart';
import 'package:build_resolvers/build_resolvers.dart';

part 'data_response.g.dart';

@JsonSerializable(
  explicitToJson: true,
  genericArgumentFactories: true,
)
class DataResponse<T> {
  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'code')
  final String? code;

  @JsonKey(name: 'data')
  final T? data;

  DataResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory DataResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$DataResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$DataResponseToJson(this, toJsonT);
}
