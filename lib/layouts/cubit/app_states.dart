import 'package:shop_app/models/update_user_dat_model.dart';

abstract class AppStates {}

class AppIntialState extends AppStates {}

class ChangeBottomNavState extends AppStates {}

class HomeLoadingDataState extends AppStates {}

class HomeSucessDataState extends AppStates {}

class HomeOnErrorDataState extends AppStates {}

class CatagoriesOnLoadingState extends AppStates {}

class CatagoriesSucessState extends AppStates {}

class CatagoriesOnErrorState extends AppStates {}

class FavouriteChangeSucessState extends AppStates {}

class FavourieChangeOnErrorState extends AppStates {}

class FavourieChangeState extends AppStates {}

class FavouritesOnLoadingState extends AppStates {}

class FavouritesSucessState extends AppStates {}

class FavouritesOnErrorState extends AppStates {}

class UserDataOnLoadingState extends AppStates {}

class UserDataSucessState extends AppStates {}

class UserDataOnErrorState extends AppStates {}

class UpdatUserDataOnLoadingState extends AppStates {}

class UpdatUserDataSucessState extends AppStates {
  UpdateUserDataModel updateUserDataModel;
  UpdatUserDataSucessState(this.updateUserDataModel);
}

class UpdatUserDataOnErrorState extends AppStates {}

class CartAddingOnLoadingState extends AppStates {}

class CartAddingSucessState extends AppStates {
  String message;
  CartAddingSucessState(this.message);
}

class CartAddingOnErrorState extends AppStates {}

class CartGettingDataOnLoadingState extends AppStates {}

class CartGettingDataSucessState extends AppStates {}

class CartGettingDataOnErrorState extends AppStates {}

class ChangingColorOfShoppingCartIconState extends AppStates {}
