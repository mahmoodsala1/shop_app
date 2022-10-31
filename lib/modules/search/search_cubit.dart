import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/search_states.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchIntialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;
  void searchProduct({required String searchText}) {
    emit(SearchOnLoadinglState());
    DioHelper.postData(
            url: 'products/search', data: {"text": searchText}, token: token)
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel.toString());
      emit(SearchSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
