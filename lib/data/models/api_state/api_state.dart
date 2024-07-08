import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_state.freezed.dart';

@freezed
class ApiState with _$ApiState {
  const factory ApiState.initial() = ApiStateInitial;
  const factory ApiState.loading() = ApiStateLoading;
  const factory ApiState.loaded(dynamic data) = ApiStateLoaded;
  const factory ApiState.error(String message) = ApiStateError;
}