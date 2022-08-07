abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavTab extends AppStates {}

class AppChangePageValue extends AppStates {}

class AppGetPopularProductsLoadingState extends AppStates {}

class AppGetPopularProductsSuccessState extends AppStates {}

class AppGetPopularProductsFailureState extends AppStates {}

class AppGetRecommendedProductsLoadingState extends AppStates {}

class AppGetRecommendedProductsSuccessState extends AppStates {}

class AppGetRecommendedProductsFailureState extends AppStates {}

class AppIncrementQuantityState extends AppStates {}

class AppDecrementQuantityState extends AppStates {}

class AppIncrementCartItemQuantityState extends AppStates {}

class AppDecrementCartItemQuantityState extends AppStates {}

class AppAddToCartState extends AppStates {}

class AppInitProductState extends AppStates {}

class AppRemoveFromCartState extends AppStates {}

class AppSetTotalPriceState extends AppStates {}
