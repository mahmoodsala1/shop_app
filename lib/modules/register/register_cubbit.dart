import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/register_model.dart';
import 'package:shop_app/modules/register/register_states.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shared/shared_pref.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  RegisterModel? registerModel;
  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: 'register', data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone
    }).then((value) {
      // print(value.data);
      registerModel = RegisterModel.fromJson(value.data);

      emit(ShopRegisterSuccessState(registerModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopRegisterErrorState(onError.toString()));
    });
  }

  IconData suffixIcon = Icons.visibility_off_outlined;
  bool isPassWord = true;
  void changePasswordVisibilty() {
    isPassWord = !isPassWord;
    suffixIcon = isPassWord ? Icons.visibility_off_outlined : Icons.visibility;
    emit(ShopRegisterSuffixTapState());
  }
}
