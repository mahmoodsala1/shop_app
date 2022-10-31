import 'package:shop_app/modules/register/register_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  RegisterModel registerModel;
  ShopRegisterSuccessState(this.registerModel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  String Registererror;

  ShopRegisterErrorState(this.Registererror);
}

class ShopRegisterSuffixTapState extends ShopRegisterStates {}
