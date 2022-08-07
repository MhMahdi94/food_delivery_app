// ignore_for_file: iterable_contains_unrelated_type

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/shared/components.dart';
import 'package:food_delivery/shared/cubit/states.dart';
import 'package:food_delivery/shared/network/end_points.dart';
import 'package:food_delivery/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  double? currentPageValue = 0;
  void changePageValue(value) {
    currentPageValue = value;
    emit(AppChangePageValue());
  }

  //Get Popular Products
  ProductModel? productModel;
  bool isProductLodaded = false;
  void getPopularProductModel() {
    emit(AppGetPopularProductsLoadingState());
    DioHelper.getData(url: POPULAR_PRODUCT).then((value) {
      productModel = ProductModel.fromJson(value.data);
      isProductLodaded = true;
      emit(AppGetPopularProductsSuccessState());
    }).catchError((error) {
      emit(AppGetPopularProductsFailureState());
    });
  }

  //Get Recommended Food
  ProductModel? recommendedProductModel;
  void getRecommendedFood() {
    emit(AppGetRecommendedProductsLoadingState());
    DioHelper.getData(url: RECOMMENDED_PRODUCT).then((value) {
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
  double totalPrice = 0;

  void addToCart(CartModel model) {
    carts.add(model);
    quantity = 0;

    emit(AppAddToCartState());
  }

  void setTotalPrice() {
    List<int> itemPrices = [];
    totalPrice = 0;
    if (carts.isEmpty) {
      totalPrice = 0;
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
}
