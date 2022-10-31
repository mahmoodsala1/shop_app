import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/cubit/app_cubit.dart';
import 'package:shop_app/layouts/cubit/app_states.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = AppCubit.get(context).cartModel;
          return Scaffold(
            appBar: AppBar(),
            body: model == null
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Total:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20)),
                              padding: EdgeInsets.all(7),
                              child: Text(
                                '${model.data.total.toStringAsFixed(2)}\$',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            )
                          ],
                        ),
                        Container(
                            height: 50,
                            child: Divider(
                              color: Colors.grey,
                              height: 5,
                            )),
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return Container(
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
                                              image: NetworkImage(model
                                                  .data
                                                  .cartItems[index]
                                                  .product
                                                  .image)),
                                          if (model.data.cartItems[index]
                                                  .product.oldPrice !=
                                              model.data.cartItems[index]
                                                  .product.price)
                                            Container(
                                              color: Colors.red,
                                              child: Text(
                                                'Discount',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white),
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
                                                '${model.data.cartItems[index].product.name}',
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
                                                    '${model.data.cartItems[index].product.price}\$',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    width: 12,
                                                  ),
                                                  if (model
                                                          .data
                                                          .cartItems[index]
                                                          .product
                                                          .discount !=
                                                      0)
                                                    Text(
                                                      '${model.data.cartItems[index].product.oldPrice}\$',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  Spacer(),
                                                  IconButton(
                                                      onPressed: () {
                                                        AppCubit.get(context)
                                                            .putInCart(
                                                                id: AppCubit.get(
                                                                        context)
                                                                    .cartModel!
                                                                    .data
                                                                    .cartItems[
                                                                        index]
                                                                    .product
                                                                    .id);
                                                      },
                                                      icon: Icon(
                                                        Icons
                                                            .shopping_cart_sharp,
                                                        color: AppCubit.get(
                                                                        context)
                                                                    .cartMap[
                                                                AppCubit.get(
                                                                        context)
                                                                    .cartModel!
                                                                    .data
                                                                    .cartItems[
                                                                        index]
                                                                    .product
                                                                    .id]!
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                      )),
                                                  CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor: AppCubit.get(
                                                                        context)
                                                                    .favouritesMap[
                                                                model
                                                                    .data
                                                                    .cartItems[
                                                                        index]
                                                                    .product
                                                                    .id] ==
                                                            true
                                                        ? Colors.blue
                                                        : Colors.grey,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          AppCubit.get(context)
                                                              .changeFavourite(
                                                                  id: model
                                                                      .data
                                                                      .cartItems[
                                                                          index]
                                                                      .product
                                                                      .id);
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
                                    height: 20,
                                  ),
                              itemCount: AppCubit.get(context)
                                  .cartModel!
                                  .data
                                  .cartItems
                                  .length
                              //  AppCubit.get(context).cartModel!.data.cartItems.length
                              ),
                        ),
                      ],
                    ),
                  ),
          );
        });
  }
}
