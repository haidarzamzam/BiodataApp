import 'package:biodata_app/data/blocs/biodatas_bloc.dart';
import 'package:biodata_app/data/blocs/bloc_provider.dart';
import 'package:biodata_app/screen/add_biodata_screen.dart';
import 'package:flutter/material.dart';

var routes = <String, WidgetBuilder>{
  '/addBiodata': (BuildContext context) => BlocProvider(
        bloc: BiodatasBloc(),
        child: AddBiodataScreen(),
      ),
};

class MyNavigator {
  static void goToRegister(BuildContext context) {
    Navigator.pushNamed(context, '/addBiodata');
  }
}
