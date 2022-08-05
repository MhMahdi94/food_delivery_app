abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangePageValue extends AppStates {}

class AppGetPopularProductsLoadingState extends AppStates {}

class AppGetPopularProductsSuccessState extends AppStates {}

class AppGetPopularProductsFailureState extends AppStates {}

class AppGetRecommendedProductsLoadingState extends AppStates {}

class AppGetRecommendedProductsSuccessState extends AppStates {}

class AppGetRecommendedProductsFailureState extends AppStates {}
