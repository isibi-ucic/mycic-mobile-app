part of 'transkrip_bloc.dart';

@freezed
class TranskripState with _$TranskripState {
  const factory TranskripState.initial() = _Initial;
  const factory TranskripState.loading() = _Loading;
  const factory TranskripState.success(TranskripResponseModel transkrip) =
      _Success;
  const factory TranskripState.error(String message) = _Error;
}
