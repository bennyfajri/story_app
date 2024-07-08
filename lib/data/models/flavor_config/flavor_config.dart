
import 'package:freezed_annotation/freezed_annotation.dart';

part 'flavor_config.freezed.dart';

@freezed
class FlavorConfig with _$FlavorConfig {
  const factory FlavorConfig.free() = FlavorConfigFree;
  const factory FlavorConfig.paid() = FlavorConfigPaid;
}