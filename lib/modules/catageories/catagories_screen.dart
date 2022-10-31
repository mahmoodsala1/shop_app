import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/cubit/app_cubit.dart';
import 'package:shop_app/layouts/cubit/app_states.dart';

import '../../models/catagories_model.dart';

class CatagoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: AppCubit.get(context).catagoriesModel != null
                ? ListView.separated(
                    itemBuilder: (context, index) => catagoriesItemBuilder(
                        AppCubit.get(context)
                            .catagoriesModel!
                            .data
                            .data[index]),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 15,
                        ),
                    itemCount:
                        AppCubit.get(context).catagoriesModel!.data.data.length)
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        });
  }

  Widget catagoriesItemBuilder(CatagoryDataModel catagoryDataModel) {
    return Row(
      children: [
        Image(
            width: 100,
            height: 100,
            image: NetworkImage(catagoryDataModel.image)),
        SizedBox(
          width: 20,
        ),
        Text(
          catagoryDataModel.name,
          style: TextStyle(fontSize: 23),
        ),
        Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_forward_ios),
          iconSize: 20,
        )
      ],
    );
  }
}
