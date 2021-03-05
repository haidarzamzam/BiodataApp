import 'dart:async';

import 'package:biodata_app/data/blocs/bloc_provider.dart';
import 'package:biodata_app/data/database.dart';
import 'package:biodata_app/data/models/gallery_model.dart';

class GalleryBloc implements BlocBase {
  final _gallerysController = StreamController<List<GalleryModel>>.broadcast();

  StreamSink<List<GalleryModel>> get _ingallerys => _gallerysController.sink;

  Stream<List<GalleryModel>> get gallerys => _gallerysController.stream;

  final _addGalleryController = StreamController<GalleryModel>.broadcast();

  StreamSink<GalleryModel> get inAddGalery => _addGalleryController.sink;

  @override
  void dispose() {
    _gallerysController.close();
    _addGalleryController.close();
  }

  GalleryBloc(int id) {
    getGallery(id);
    _addGalleryController.stream.listen(_handleAddGallery);
  }

  void getGallery(int id) async {
    List<GalleryModel> gallerys = await DBProvider.db.getGallerys(id);
    _ingallerys.add(gallerys);
  }

  void _handleAddGallery(GalleryModel galleryModel) async {
    await DBProvider.db.newGallery(galleryModel);
    getGallery(galleryModel.idUser);
  }
}
