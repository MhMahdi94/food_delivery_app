import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/models/product_model.dart';
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
}
