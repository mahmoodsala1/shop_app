import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/cubit/app_cubit.dart';
import 'package:shop_app/modules/search/search_cubit.dart';
import 'package:shop_app/modules/search/search_states.dart';
import 'package:shop_app/shared/components.dart';

class SearchScreen extends StatelessWidget {
  @override
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String? val;
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (
            context,
            state,
          ) {
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    textFormField(
                        controller: searchController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'must have text';
                          }
                          return null;
                        },
                        textInputType: TextInputType.text,
                        lable: 'Searche',
                        prefix: Icons.search,
                        onsubmitted: (value) {
                          val = value;
                          SearchCubit.get(context)
                              .searchProduct(searchText: value);
                          FocusScope.of(context).unfocus();
                        }),
                    if (state is SearchOnLoadinglState)
                      const LinearProgressIndicator(),
                    if (state is SearchSucessState)
                      Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) => Container(
                                    height: 120,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          alignment:
                                              AlignmentDirectional.bottomStart,
                                          children: [
                                            Image(
                                                height: 120,
                                                width: 120,
                                                image: NetworkImage(
                                                    SearchCubit.get(context)
                                                        .searchModel!
                                                        .data
                                                        .dataList[index]
                                                        .image)),
                                          ],
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${SearchCubit.get(context).searchModel!.data.dataList[index].name}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    height: 1.2,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Spacer(),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${SearchCubit.get(context).searchModel!.data.dataList[index].price}\$',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    Spacer(),
                                                    IconButton(
                                                        onPressed: () {
                                                          AppCubit.get(context)
                                                              .putInCart(
                                                                  id: AppCubit.get(
                                                                          context)
                                                                      .homeModel!
                                                                      .data
                                                                      .products[
                                                                          index]
                                                                      .id);
                                                        },
                                                        icon: Icon(
                                                          Icons
                                                              .shopping_cart_sharp,
                                                          color: Colors.blue,
                                                        )),
                                                    CircleAvatar(
                                                      radius: 20,
                                                      backgroundColor: AppCubit
                                                                      .get(
                                                                          context)
                                                                  .favouritesMap[SearchCubit
                                                                      .get(
                                                                          context)
                                                                  .searchModel!
                                                                  .data
                                                                  .dataList[
                                                                      index]
                                                                  .id] ==
                                                              true
                                                          ? Colors.blue
                                                          : Colors.grey,
                                                      child: IconButton(
                                                          onPressed: () {
                                                            AppCubit.get(
                                                                    context)
                                                                .changeFavourite(
                                                                    id: SearchCubit.get(
                                                                            context)
                                                                        .searchModel!
                                                                        .data
                                                                        .dataList[
                                                                            index]
                                                                        .id);
                                                            SearchCubit.get(
                                                                    context)
                                                                .searchProduct(
                                                                    searchText:
                                                                        val!);
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .favorite_border,
                                                            size: 16,
                                                          )),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 20,
                                  ),
                              itemCount: SearchCubit.get(context)
                                  .searchModel!
                                  .data
                                  .dataList
                                  .length))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
