part of 'shop_page_bloc.dart';

@freezed
class ShopPageEvent with _$ShopPageEvent {
  const factory ShopPageEvent.tryBuy({
    required ShopItem shopItem,
  }) = _tryBuy;
}
