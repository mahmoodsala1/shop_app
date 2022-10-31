import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/cubit/app_cubit.dart';
import 'package:shop_app/layouts/cubit/app_states.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          var model = AppCubit.get(context).favouriteModel ?? null;

          return Scaffold(
              body: model != null
                  ? ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          height: 120,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.bottomStart,
                                children: [
                                  Image(
                                      height: 120,
                                      width: 120,
                                      image: NetworkImage(cubit
                                          .favouriteModel!
                                          .data!
                                          .data![index]!
                                          .productData!
                                          .image!)),
                                  if (cubit.favouriteModel!.data!.data![index]!
                                          .productData!.price !=
                                      cubit.favouriteModel!.data!.data![index]!
                                          .productData!.old_price)
                                    Container(
                                      color: Colors.red,
                                      child: Text(
                                        'Discount',
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                    ),
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
                                        '${cubit.favouriteModel!.data!.data![index]!.productData!.name}',
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
                                            '${cubit.favouriteModel!.data!.data![index]!.productData!.price}\$',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          if (cubit
                                                  .favouriteModel!
                                                  .data!
                                                  .data![index]!
                                                  .productData!
                                                  .discount !=
                                              0)
                                            Text(
                                              '${cubit.favouriteModel!.data!.data![index]!.productData!.old_price}\$',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          Spacer(),
                                          IconButton(
                                              onPressed: () {
                                                AppCubit.get(context).putInCart(
                                                    id: AppCubit.get(context)
                                                        .favouriteModel!
                                                        .data
                                                        .data[index]
                                                        .productData
                                                        .id);
                                              },
                                              icon: Icon(
                                                Icons.shopping_cart_sharp,
                                                color: AppCubit.get(context)
                                                            .cartMap[
                                                        AppCubit.get(context)
                                                            .favouriteModel!
                                                            .data
                                                            .data[index]
                                                            .productData
                                                            .id]!
                                                    ? Colors.blue
                                                    : Colors.grey,
                                              )),
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundColor:
                                                cubit.favouritesMap[cubit
                                                            .favouriteModel!
                                                            .data
                                                            .data[index]
                                                            .productData
                                                            .id] ==
                                                        true
                                                    ? Colors.blue
                                                    : Colors.grey,
                                            child: IconButton(
                                                onPressed: () {
                                                  cubit.changeFavourite(
                                                      id: cubit
                                                          .favouriteModel!
                                                          .data!
                                                          .data![index]!
                                                          .productData
                                                          .id);
                                                  print(cubit.favouritesMap[
                                                      cubit.homeModel!.data
                                                          .products[index].id]);
                                                },
                                                icon: Icon(
                                                  Icons.favorite_border,
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
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: 15,
                          ),
                      itemCount: model.data.data.length)
                  : Center(
                      child: CircularProgressIndicator(),
                    ));
        });
  }
}
