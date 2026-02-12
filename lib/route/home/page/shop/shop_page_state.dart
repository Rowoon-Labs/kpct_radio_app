part of 'shop_page_bloc.dart';

@freezed
class ShopPageState with _$ShopPageState {
  const factory ShopPageState({
    @Default([]) List<ShopItemId> processing,
  }) = _ShopPageState;
}
