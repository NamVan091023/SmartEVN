import 'package:json_annotation/json_annotation.dart';

part 'list_data_response.g.dart';

@JsonSerializable(
  explicitToJson: true,
  genericArgumentFactories: true,
)
class ListDataResponse<T> {
  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'code')
  final String? code;

  @JsonKey(name: 'data')
  List<T>? data;

  @JsonKey(name: 'totalPages')
  final int? totalPages;

  ListDataResponse(
    this.status,
    this.message,
    this.code,
    this.data,
    this.totalPages,
  );

  factory ListDataResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ListDataResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ListDataResponseToJson(this, toJsonT);
}
