import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layouts/cubit/app_cubit.dart';
import 'package:shop_app/layouts/cubit/app_states.dart';
import 'package:shop_app/models/home_model.dart';

import '../../models/catagories_model.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is CartAddingSucessState) {
        Fluttertoast.showToast(
          msg: state.message,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
        );
      }
    }, builder: (context, state) {
      var cubit = AppCubit.get(context);
      return (cubit.homeModel == null || cubit.catagoriesModel == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                      items: cubit.homeModel!.data.banners
                          .map((e) => Image(
                                image: NetworkImage(e.image),
                              ))
                          .toList(),
                      options: CarouselOptions(
                        height: 250,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                      )),
                  Text(
                    'Catagories',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      itemBuilder: (context, index) => listViewItemBuilder(
                          cubit.catagoriesModel!.data.data[index]),
                      itemCount: cubit.catagoriesModel!.data.data.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                      physics: BouncingScrollPhysics(),
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    child: GridView.count(
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.5,
                      children: List.generate(
                          cubit.homeModel!.data.products.length,
                          (index) => Container(
                                padding: EdgeInsets.all(10),
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional.bottomStart,
                                        children: [
                                          Image(
                                              image: NetworkImage(cubit
                                                  .homeModel!
                                                  .data
                                                  .products[index]
                                                  .image)),
                                          if (cubit.homeModel!.data
                                                  .products[index].price !=
                                              cubit.homeModel!.data
                                                  .products[index].old_price)
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
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${cubit.homeModel!.data.products[index].name}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        height: 1.2,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${cubit.homeModel!.data.products[index].price.round()}\$',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        if (cubit.homeModel!.data
                                                .products[index].old_price
                                                .round() !=
                                            cubit.homeModel!.data
                                                .products[index].price
                                                .round())
                                          Text(
                                            '${cubit.homeModel!.data.products[index].old_price.round()}\$',
                                            style: TextStyle(
                                                fontSize: 12,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        Spacer(),
                                        IconButton(
                                            onPressed: () {
                                              AppCubit.get(context).putInCart(
                                                  id: cubit.homeModel!.data
                                                      .products[index].id);

                                              print(
                                                  '${cubit.homeModel!.data.products[index].id}');
                                            },
                                            icon: Icon(
                                              Icons.shopping_cart_sharp,
                                              color: cubit.cartMap[cubit
                                                      .homeModel!
                                                      .data
                                                      .products[index]
                                                      .id]!
                                                  ? Colors.blue
                                                  : Colors.grey,
                                            )),
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundColor: cubit.favouritesMap[
                                                      cubit
                                                          .homeModel!
                                                          .data
                                                          .products[index]
                                                          .id] ==
                                                  true
                                              ? Colors.blue
                                              : Colors.grey,
                                          child: IconButton(
                                              onPressed: () {
                                                cubit.changeFavourite(
                                                    id: cubit.homeModel!.data
                                                        .products[index].id);
                                                print(cubit.favouritesMap[cubit
                                                    .homeModel!
                                                    .data
                                                    .products[index]
                                                    .id]);
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
                              )),
                    ),
                  )
                ],
              ),
            );
    });
  }

  Widget listViewItemBuilder(CatagoryDataModel dataModel) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(width: 100, height: 100, image: NetworkImage(dataModel.image)),
        Container(
          alignment: Alignment.bottomCenter,
          width: 100,
          height: 15,
          color: Colors.black.withOpacity(.8),
          child: Text(
            '${dataModel.name}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
