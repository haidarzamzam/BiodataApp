import 'dart:async';

import 'package:biodata_app/data/blocs/bloc_provider.dart';
import 'package:biodata_app/data/database.dart';
import 'package:biodata_app/data/models/biodata_model.dart';

class BiodatasBloc implements BlocBase {
  final _biodatasController = StreamController<List<BiodataModel>>.broadcast();

  StreamSink<List<BiodataModel>> get _inBiodatas => _biodatasController.sink;

  Stream<List<BiodataModel>> get biodatas => _biodatasController.stream;

  final _biodataController = StreamController<BiodataModel>.broadcast();

  StreamSink<BiodataModel> get inBiodata => _biodataController.sink;

  Stream<BiodataModel> get biodata => _biodataController.stream;

  final _addBiodataController = StreamController<BiodataModel>.broadcast();

  StreamSink<BiodataModel> get inAddBioadata => _addBiodataController.sink;

  BiodatasBloc() {
    getBiodatas();
    _biodataController.stream.listen(getBiodata);
    _addBiodataController.stream.listen(_handleAddBiodata);
  }

  @override
  void dispose() {
    _biodatasController.close();
    _biodataController.close();
    _addBiodataController.close();
  }

  void getBiodatas() async {
    List<BiodataModel> biodatas = await DBProvider.db.getBioadatas();
    _inBiodatas.add(biodatas);
  }

  void getBiodata(BiodataModel biodataModel) async {
    BiodataModel biodata = await DBProvider.db.getBioadata(biodataModel);
    inBiodata.add(biodata);
  }

  void _handleAddBiodata(BiodataModel biodataModel) async {
    await DBProvider.db.newBiodata(biodataModel);
    getBiodatas();
  }
}
