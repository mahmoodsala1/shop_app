import "package:universal_html/html.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/cubit/app_states.dart';
import 'package:shop_app/models/favourite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/catageories/catagories_screen.dart';
import 'package:shop_app/modules/favourites/favourites_screen.dart';
import 'package:shop_app/modules/products/product_screen.dart';
import 'package:shop_app/modules/settings/Settings_screen.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/models/update_user_dat_model.dart';
import '../../models/cart_model.dart';
import '../../models/catagories_model.dart';
import '../../models/change_favourite_model.dart';
import 'package:shop_app/models/login.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreen = [
    ProductsScreen(),
    CatagoriesScreen(),
    FavouritesScreen(),
    SettingsScreen()
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favouritesMap = {};
  Map<int, bool> cartMap = {};
  void getHomeData() {
    emit(HomeLoadingDataState());
    DioHelper.getData(url: Home, token: token).then((value) {
      homeModel = HomeModel.fromJason(value.data);
      homeModel!.data.products.forEach((element) {
        cartMap.addAll({element.id: element.in_cart});

        favouritesMap.addAll({element.id: element.in_favorites});
      });
      // print(favouritesMap.toString());
      emit(HomeSucessDataState());
    }).catchError((onError) {
      print(onError.toString());
      emit(HomeOnErrorDataState());
    });
  }

  CatagoriesModel? catagoriesModel;
  void getCatagoriesData() {
    DioHelper.getData(url: Catagories).then((value) {
      catagoriesModel = CatagoriesModel.fromJason(value.data);
      print(catagoriesModel!.data.data[1].image);
      emit(CatagoriesSucessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(CatagoriesOnErrorState());
    });
  }

  ChangeFavouriteModel? favouritChangeModel;
  Future<void> changeFavourite({required int id}) async {
    favouritesMap[id] = !favouritesMap[id]!;
    emit(FavourieChangeState());

    await DioHelper.postData(
            url: 'favorites', data: {'product_id': id}, token: token)
        .then((value) {
      favouritChangeModel = ChangeFavouriteModel.fromJson(value.data);
      if (!favouritChangeModel!.status) {
        favouritesMap[id] = !favouritesMap[id]!;
      } else {
        getFavouritesModel();
      }
      favouritChangeModel = ChangeFavouriteModel.fromJson(value.data);
      print(favouritChangeModel!.data.product.id);
      emit(FavouriteChangeSucessState());
    }).catchError((error) {
      favouritesMap[id] = !favouritesMap[id]!;
      print(error.toString());
      emit(FavourieChangeOnErrorState());
    });
  }

  FavouriteModel? favouriteModel;
  void getFavouritesModel() {
    DioHelper.getData(url: 'favorites', token: token).then((value) {
      favouriteModel = FavouriteModel.fromJson(value.data);

      print(favouriteModel);
      emit(FavouritesSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(FavouritesOnErrorState());
    });
  }

  LoginModel? userData;
  void getUserDataModel() {
    emit(UserDataOnLoadingState());
    DioHelper.getData(url: 'profile', token: token).then((value) {
      userData = LoginModel.fromJson(value.data);

      print(favouriteModel);
      emit(UserDataSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(UserDataOnErrorState());
    });
  }

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility_off_outlined;
  void changIcon() {
    isPassword = !isPassword;
    suffixIcon = isPassword ? Icons.visibility_off_outlined : Icons.visibility;
  }

  UpdateUserDataModel? updateUserDataModel;
  void updateUserData(
      {required String email,
      required String password,
      required String phone,
      required String name}) {
    emit(UpdatUserDataOnLoadingState());
    DioHelper.putData(
            path: 'update-profile',
            data: {
              'name': name,
              'phone': phone,
              'email': email,
              'password': password,
              'image':
                  'https://student.valuxapps.com/storage/uploads/categories/1630142480dvQxx.3658058.jpg'
            },
            token: token!)
        .then((value) {
      print(value.data);
      updateUserDataModel = UpdateUserDataModel.fromJson(value.data);
      emit(UpdatUserDataSucessState(updateUserDataModel!));
    }).catchError((error) {
      print(error.toString());
      emit(UpdatUserDataOnErrorState());
    });
  }

  String? putInCartMessage;
  void putInCart({required int id}) {
    emit(CartAddingOnLoadingState());
    cartMap[id] = !cartMap[id]!;
    DioHelper.postData(url: 'carts', data: {'product_id': id}, token: token)
        .then((value) {
      putInCartMessage = value.data['message'];
      if (!value.data['status']) {
        cartMap[id] = !cartMap[id]!;
      } else {
        getCartModel();
      }
      emit(CartAddingSucessState(value.data['message']));
    }).catchError((error) {
      cartMap[id] = !cartMap[id]!;

      print(error.toString());
      emit(CartAddingOnErrorState());
    });
  }

  CartModel? cartModel;
  void getCartModel() {
    emit(CartGettingDataOnLoadingState());
    DioHelper.getData(url: 'carts', token: token).then((value) {
      cartModel = CartModel.fromJson(value.data);

      print(cartModel!.data.cartItems.length);
      emit(CartGettingDataSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(CartGettingDataOnErrorState());
    });
  }
}
