import 'package:freezed_annotation/freezed_annotation.dart';

part 'loading_state.freezed.dart';

@freezed
class DataState<T> with _$DataState<T> {
  const factory DataState.loading() = DataStateLoading<T>;
  const factory DataState.loaded(T data) = DataStateLoaded<T>;
}