import 'dart:async';

import 'package:biodata_app/data/blocs/bloc_provider.dart';
import 'package:biodata_app/data/database.dart';
import 'package:biodata_app/data/models/biodata_model.dart';

class BiodatasBloc implements BlocBase {
  final _biodatasController = StreamController<List<BiodataModel>>.broadcast();

  StreamSink<List<BiodataModel>> get _inBiodatas => _biodatasController.sink;

  Stream<List<BiodataModel>> get biodatas => _biodatasController.stream;

  final _addBiodataController = StreamController<BiodataModel>.broadcast();

  StreamSink<BiodataModel> get inAddBioadata => _addBiodataController.sink;

  BiodatasBloc() {
    getBiodatas();
    _addBiodataController.stream.listen(_handleAddBiodata);
  }

  @override
  void dispose() {
    _biodatasController.close();
    _addBiodataController.close();
  }

  void getBiodatas() async {
    List<BiodataModel> biodatas = await DBProvider.db.getBioadatas();
    _inBiodatas.add(biodatas);
  }

  void _handleAddBiodata(BiodataModel biodataModel) async {
    await DBProvider.db.newBiodata(biodataModel);
    getBiodatas();
  }
}
