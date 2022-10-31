import 'package:shop_app/models/login.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  LoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates {
  String error;

  ShopLoginErrorState(this.error);
}

class ShopLoginSuffixTapState extends ShopLoginStates {}
