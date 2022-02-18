part of '../index.dart';

class HomeEvents {
  static final initPage = 1;
  static final _localLetter = AppParams.localLetter;
  static final _productLetter = AppParams.productLetter;
  static final _delivery = AppParams.flagDelivery;
  static final _pickUp = AppParams.flagPickUp;
  static final _all = AppParams.flagAll;

  static bool get isDelivery => FilterState().getValue?.order == _delivery;
  static bool get isPickUp => FilterState().getValue?.order == _pickUp;
  static bool get isAllOrder => FilterState().getValue?.order == _all;

  static bool get isProduct => FilterState().getValue?.isProductFilter;

  static goToFood(product, [bool byPassback = false]) {
    NavigationService().navigateTo(screen: FoodView(product, byPassback));
  }

  static goToRestaurant(local) {
    NavigationService().navigateTo(screen: RestaurantView(local));
  }

  static Future<bool> onBackProduct(product, bool bypass) async {
    NavigationService().pop();
    if (!bypass) verifyPopProduct(product);
    return false;
  }

  static verifyPopProduct(product) {
    if (CartState().getValue.isNotEmpty)
      goToRestaurant(convertToRestaurant(product));
  }

  /// [canNavigate] [dashboard] [router] [validation]
  static get canNavigate {
    final products = CartState().getValue;
    if (products.isNotEmpty)
      goToRestaurant(convertToRestaurant(products.last.product));
    return products.isEmpty;
  }

  static LocalModel convertToRestaurant(ProductModel product) =>
      LocalModel.fromJson(product.toJson());

  static Future addProduct(ProductModel value) async {
    final address = AddressState().getValue;
    if (address != null) {
      final productItem = CartItemModel()
        ..product = value
        ..qty = 1;

      CartState().doAddMore(productItem);
    } else {
      DialogService.validateLocation;
    }
  }

  //static Future loadLocalProducts(id) async =>
  //  await HomeRepository.getLocalProducts(id);

  static Future loadLocalProducts(LocalModel local) async {
    final address = AddressState().getValue;

    local.geolocationCode = address?.code ?? '';
    local.latitude = address?.latitude ?? 0;
    local.longitude = address?.longitude ?? 0;

    return await HomeRepository.getLocalProducts(local);
  }

  static Future addFavourite(FavouriteModel favourite) async {
    return await HomeRepository.addOrUpdateFavourite(favourite, true);
  }

  static Future updateFavourite(FavouriteModel favourite) async {
    return await HomeRepository.addOrUpdateFavourite(favourite, false);
  }

  static Future get loadCategories async =>
      await HomeRepository.getCategories();

  static Future get initCategories async =>
      await HomeRepository.getCategories(false);
  static Future get initProducts async => await HomeRepository._reset;
  static Future get cleanElements async => await HomeRepository._cleanElements;

  static Future<bool> get nextPage async => await loadList();

  static Future<void> reload() async {
    HomeRepository._reset;
    ReloadState().reload;
  }

  static Future<void> reloadLocalWithProducts() async {
    HomeRepository._reset;
    canNavigate;
  }

  static Future<bool> loadList({
    String search,
    String category,
    String order,
    String variant,
    bool reload,
    bool showLoading = false,
  }) async {
    if (await AppConnectivity.check()) {
      if (!FilterState().isLoading) {
        FilterState().setLoading;

        final filter = FilterState().getValue;

        bool reset = search is String ||
            category is String ||
            reload is bool ||
            order is String ||
            variant is String;

        final codCLient = SessionService.getCodClient;
        final address = AddressState().getValue;

        if (variant is String) filter.isProductLocal = variant;
        if (category is String) filter.catCode = category;
        if (order is String) filter.orderType = order;
        if (search is String) filter.searchInput = search;

        filter.geolocationCode = address?.code ?? '';
        filter.latitude = address?.latitude ?? 0;
        filter.longitude = address?.longitude ?? 0;
        filter.codeclient = codCLient ?? '';
        filter.pageNumber = reset ? initPage : FilterState().getPage;

        if (variant is String || reset) {
          FilterState().setLoaded;
          HomeEvents.reload();
          return true;
        }

        FilterState().update(filter);

        final response = await HomeRepository.getList(showLoading);

        FilterState().setLoaded;
        return response;
      }
      return true;
    }
    return false;
  }

  static void onSwitchTypes(ROUTE_SEARCH type) async {
    var valueType;
    switch (type) {
      case ROUTE_SEARCH.FOOD:
        valueType = _productLetter;
        break;
      case ROUTE_SEARCH.RESTAURANT:
        valueType = _localLetter;
        break;
      default:
        valueType = _localLetter;
    }
    loadList(variant: valueType, showLoading: true);
  }

  static void onSwitchByOrder(ORDER_TYPE type) async {
    var valueType;
    switch (type) {
      case ORDER_TYPE.ALL:
        valueType = _all;
        break;
      case ORDER_TYPE.DELIVERY:
        valueType = _delivery;
        break;
      case ORDER_TYPE.PICKUP:
        valueType = _pickUp;
        break;
      default:
        valueType = _pickUp;
    }
    loadList(order: valueType, showLoading: true);
  }

  static void onSwitchCategories(type) async {
    if (await AppConnectivity.check()) {
      final filter = FilterState().getValue;
      if (type is String) filter.catCode = type;
      FilterState().update(filter);
      HomeRepository._reset;
      // loadList(category: type, showLoading: true);
    }
  }

  static void onSearch(value) {
    loadList(search: value, showLoading: true);
  }

  static get cleanSearch {
    final filter = FilterState().getValue;
    filter.searchInput = '';
    FilterState().update(filter);
  }

  static onSelectNav(ROUTE_PAGE nav) async {
    switch (nav) {
      case ROUTE_PAGE.HOME:
        await DialogService.doNotify;
        break;
      case ROUTE_PAGE.CART:
        NavController.goToCart();
        break;
      case ROUTE_PAGE.ORDER:
        NavController.goToOrder();
        break;
      case ROUTE_PAGE.PROFILE:
        NavController.goToProfile();
        break;
      default:
    }
  }
}
