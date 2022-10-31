import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/login.dart';
import 'package:shop_app/modules/login/shop_login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/shared_pref.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  LoginModel? loginModel;
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      SharedPref.saveData(key: 'token', value: loginModel!.data!.token)
          .then((value) {
        token = loginModel!.data!.token;
      });
      token = loginModel!.data!.token;
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopLoginErrorState(onError.toString()));
    });
  }

  IconData suffixIcon = Icons.visibility_off_outlined;
  bool isPassWord = true;
  void changePasswordVisibilty() {
    isPassWord = !isPassWord;
    suffixIcon = isPassWord ? Icons.visibility_off_outlined : Icons.visibility;
    emit(ShopLoginSuffixTapState());
  }
}
