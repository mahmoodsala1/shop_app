import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shop_app/layouts/cubit/app_cubit.dart';
import 'package:shop_app/layouts/home.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/on_oarding_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/cert.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shared/shared_pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();

  await SharedPref.init();

  bool onBoardingVisited =
      SharedPref.getData(key: 'onBoardingVisitedBefore') ?? false;
  late Widget firstPageToOpen;
  if (onBoardingVisited) {
    if (token == null) {
      firstPageToOpen = Login();
    } else {
      firstPageToOpen = HomeScreen();
    }
  } else {
    firstPageToOpen = OnBoardingScreen();
  }
  print(onBoardingVisited);
  print(token);
  BlocOverrides.runZoned(
    () {
      runApp(Phoenix(
        child: ShopApp(
          firstPageToOpen: firstPageToOpen,
        ),
      ));
    },
    blocObserver: MyBlocObserver(),
  );
  DioHelper.init();
}

class ShopApp extends StatefulWidget {
  @override
  Widget firstPageToOpen;

  ShopApp({Key? key, required this.firstPageToOpen}) : super(key: key);
  _ShopAppState createState() => _ShopAppState();
}

class _ShopAppState extends State<ShopApp> {
  @override
  Widget build(BuildContext context) {
    print(token);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppCubit()
              ..getHomeData()
              ..getCatagoriesData()
              ..getFavouritesModel()
              ..getUserDataModel()
              ..getCartModel()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            textTheme: TextTheme(
          headline2: TextStyle(color: Colors.black38),
        )),
        debugShowCheckedModeBanner: false,
        home: widget.firstPageToOpen,
      ),
    );
  }
}
