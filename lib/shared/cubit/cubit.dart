import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  double? currentPageValue = 0;
  void changePageValue(value) {
    currentPageValue = value;
    emit(AppChangePageValue());
  }
}
