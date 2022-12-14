// ignore_for_file: iterable_contains_unrelated_type

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:food_delivery/models/address_model.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:food_delivery/modules/cart/cart_screen.dart';
import 'package:food_delivery/modules/history/history_screen.dart';
import 'package:food_delivery/modules/home/home_screen.dart';
import 'package:food_delivery/modules/profile/profile_screen.dart';
import 'package:food_delivery/shared/components.dart';
import 'package:food_delivery/shared/constants/constants.dart';
import 'package:food_delivery/shared/cubit/states.dart';
import 'package:food_delivery/shared/network/end_points.dart';
import 'package:food_delivery/shared/network/local/cache_helper.dart';
import 'package:food_delivery/shared/network/remote/dio_helper.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    HomeScreen(),
    HistoryScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  List<String> titles = [
    'Home',
    'History',
    'Cart',
    'Profile',
  ];
  //bottom nav bar
  int currentIndex = 0;
  bool isCartNav = false;
  void changeBottomTabIndex(int index) {
    if (index == 2) {
      isCartNav = true;
    } else {
      isCartNav = false;
    }
    currentIndex = index;

    emit(AppChangeBottomNavTab());
  }

  double? currentPageValue = 0;
  void changePageValue(value) {
    currentPageValue = value;
    emit(AppChangePageValue());
  }

  bool? isFavourite = false;
  void changeFavourites() {
    isFavourite = !isFavourite!;
    emit(AppChangeFavouritesState());
  }

  //onBoarding
  int pageIndex = 0;
  List<String> onboardImages = [
    'assets/images/onboard1.png',
    'assets/images/onboard2.png',
    'assets/images/onboard3.png',
  ];

  void changeOnBoardingPageValue(value) {
    pageIndex = value;
    emit(AppChangeOnBoardingPageValue());
  }

  //loading overlay
  bool saving = false;
  void loadingOverlay(bool value) {
    saving = value;
    emit(AppOverlayLoadingState());
  }

  //get user data
  UserModel? userModel;
  void getUserData() {
    emit(AppGetUserDataLoadingState());
    DioHelper.getData(url: CUSTOMER_INFO, token: token).then((value) {
      userModel = UserModel.fromJson(value.data);
      isProductLodaded = true;
      emit(AppGetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetUserDataFailureState());
    });
  }

  //Get Popular Products
  ProductModel? productModel;
  bool isProductLodaded = false;
  void getPopularProductModel() {
    emit(AppGetPopularProductsLoadingState());
    DioHelper.getData(url: POPULAR_PRODUCT, token: token).then((value) {
      productModel = ProductModel.fromJson(value.data);
      isProductLodaded = true;
      emit(AppGetPopularProductsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetPopularProductsFailureState());
    });
  }

  //Get Recommended Food
  ProductModel? recommendedProductModel;
  void getRecommendedFood() {
    emit(AppGetRecommendedProductsLoadingState());
    DioHelper.getData(url: RECOMMENDED_PRODUCT, token: token).then((value) {
      recommendedProductModel = ProductModel.fromJson(value.data);
      isProductLodaded = true;
      emit(AppGetRecommendedProductsSuccessState());
    }).catchError((error) {
      emit(AppGetRecommendedProductsFailureState());
    });
  }

  //increment/decrement quantity
  int quantity = 0;
  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      quantity = quantity + 1;
      emit(AppIncrementQuantityState());
    } else {
      quantity = quantity - 1;
      if (quantity < 0) {
        quantity = 0;
      }
      emit(AppDecrementQuantityState());
    }
  }

  void setItemQuantity(bool isIncrement, {required itemQuantity, required id}) {
    CartModel _cart = carts.firstWhere((element) => element.id == id);
    if (isIncrement) {
      itemQuantity = itemQuantity + 1;
      carts[carts.indexWhere((element) => element.id == id)].quantity =
          itemQuantity;

      emit(AppIncrementCartItemQuantityState());
    } else {
      itemQuantity = itemQuantity - 1;
      if (itemQuantity <= 0) {
        carts.removeWhere((element) => element.id == id);
        CacheHelper.removeData('cart');
        totalPrice = 0;
        emit(AppRemoveFromCartState());
      }
      carts[carts.indexWhere((element) => element.id == id)].quantity =
          itemQuantity;
      emit(AppDecrementCartItemQuantityState());
    }
  }

  void initProduct() {
    quantity = 0;
    emit(AppInitProductState());
  }

  //Cart
  List<CartModel> carts = [];
  List<CartModel> cartsHistory = [];
  double totalPrice = 0;

  void addToCart(CartModel model) {
    bool isExist = carts.any((element) => model.id == element.id);
    //print(isExist);
    if (isExist) {
      print('exist');
      carts[carts.indexWhere((element) => element.id == model.id)].quantity =
          model.quantity;
    } else {
      carts.add(model);
    }
    cartsHistory.add(model);
    quantity = 0;
    setTotalPrice();
    cacheCart();
    emit(AppAddToCartState());
  }

  void setTotalPrice() {
    List<int> itemPrices = [];
    totalPrice = 0;
    if (carts.isEmpty) {
      totalPrice = 0;
      emit(AppSetTotalPriceState());
    } else {
      carts.forEach((element) {
        itemPrices.add(element.price! * element.quantity!);
      });
      print(itemPrices);
      itemPrices.forEach((element) {
        totalPrice = totalPrice + element;
      });
      print(totalPrice);
      emit(AppSetTotalPriceState());
    }
  }

  void cacheCart() {
    List<String> list = [];
    carts.forEach((element) {
      list.add(jsonEncode(element.toJson()));
    });
    CacheHelper.setListData(key: 'cart', value: list);
    list = [];
    cartsHistory.forEach((element) {
      list.add(jsonEncode(element.toJson()));
    });
    CacheHelper.setListData(key: 'cartHistory', value: list);
  }

  void getCartDataFromLocalStorage() {
    carts = [];
    List<String> list = [];
    if (CacheHelper.sharedPreferences!.containsKey('cart')) {
      list = CacheHelper.getListData(key: 'cart');
      //print(list);
      list.forEach((element) {
        carts.add(CartModel.fromJson(jsonDecode(element)));
      });
      print(carts);
    }
    list = [];
    if (CacheHelper.sharedPreferences!.containsKey('cartHistory')) {
      list = CacheHelper.getListData(key: 'cartHistory');
      //print(list);
      list.forEach((element) {
        cartsHistory.add(CartModel.fromJson(jsonDecode(element)));
      });
      print('history:${cartsHistory}');
    }
  }

  //map & address
  bool maploading = false;
  late Position position;
  late Position pickPosition;
  Placemark placemark = Placemark();
  Placemark pickPlacemark = Placemark();
  List<AddressModel> addressList = [];
  late List<AddressModel> allAddressList;
  List<String> addressTypeList = ['home', 'office', 'others'];
  int addressTypeIndex = 0;
  late LatLng initialPosition;
  late bool serviceEnabled;
  LocationPermission? permission;
  late LatLng latLngPosition;
  late MapController mapController;

  void getCurrentUserLoaction() async {
    maploading = true;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    } else {
      print('Enabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    } else {
      print('Enabled');
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    } else {
      print('Enabled');
    }

    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true);

    //currentPosition = position;

    latLngPosition = LatLng(position.latitude, position.longitude);
    maploading = false;
    emit(AppGetUserLocationSuccessState());
    //print(latLngPosition.toString());
  }

  // void
}
