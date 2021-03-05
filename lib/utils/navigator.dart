import 'package:biodata_app/data/blocs/biodatas_bloc.dart';
import 'package:biodata_app/data/blocs/bloc_provider.dart';
import 'package:biodata_app/screen/add_biodata_screen.dart';
import 'package:biodata_app/screen/detail_biodata_screen.dart';
import 'package:flutter/material.dart';

var routes = <String, WidgetBuilder>{
  '/addBiodata': (BuildContext context) => BlocProvider(
        bloc: BiodatasBloc(),
        child: AddBiodataScreen(),
      ),
  '/detailBiodata': (
    BuildContext context,
  ) =>
      BlocProvider(
        bloc: BiodatasBloc(),
        child: DetailBiodataScreen(),
      ),
};

class MyNavigator {
  static void goToAddBiodata(BuildContext context) {
    Navigator.pushNamed(context, '/addBiodata');
  }

  static void goToDetailBiodata(BuildContext context) {
    Navigator.pushNamed(context, '/detailBiodata');
  }
}
