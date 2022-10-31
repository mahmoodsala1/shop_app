import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/cubit/app_cubit.dart';
import 'package:shop_app/layouts/cubit/app_states.dart';
import 'package:shop_app/modules/cart/cart_screen.dart';
import 'package:shop_app/modules/search/search.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (BuildContext context, Object? state) {
          var cubit = AppCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen()));
                  },
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CartScreen()));
                    },
                    icon: Icon(
                      Icons.shopping_cart_sharp,
                      color: Colors.blue,
                    ))
              ],
              title: Text(
                'salla',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            body: cubit.bottomScreen[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                selectedFontSize: 20,
                selectedItemColor: Colors.blue,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                unselectedFontSize: 15,
                unselectedItemColor: Colors.grey,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      label: 'Catageories', icon: Icon(Icons.apps)),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: 'Favourite'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'Settings'),
                ]),
          );
        });
  }
}
