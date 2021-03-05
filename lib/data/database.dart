import 'dart:async';
import 'dart:io';

import 'package:biodata_app/data/models/biodata_model.dart';
import 'package:biodata_app/data/models/gallery_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = join(documentsDir.path, 'app.db');

    return await openDatabase(path, version: 1, onOpen: (db) async {},
        onCreate: (Database db, int version) async {
      await db.execute('''
				CREATE TABLE biodata(
					id INTEGER PRIMARY KEY,
					name TEXT DEFAULT '',
					gender TEXT DEFAULT '',
					address TEXT DEFAULT '',
					phoneNumber TEXT DEFAULT '',
					email TEXT DEFAULT '',
					urlInstagram TEXT DEFAULT '',
					urlFacebook TEXT DEFAULT '',
					urlYoutube TEXT DEFAULT '',
					photoProfile TEXT DEFAULT '',
					password TEXT DEFAULT ''
				)
			''');

      await db.execute('''
				CREATE TABLE gallery(
					id INTEGER PRIMARY KEY,
					idUser INTEGER,
					photo TEXT DEFAULT ''
				)
			''');
    });
  }

  newBiodata(BiodataModel biodataModel) async {
    final db = await database;
    var res = await db.insert('biodata', biodataModel.toJson());

    return res;
  }

  getBioadatas() async {
    final db = await database;
    var res = await db.query('biodata');
    List<BiodataModel> biodatas = res.isNotEmpty
        ? res.map((biodata) => BiodataModel.fromJson(biodata)).toList()
        : [];

    return biodatas;
  }

  getBioadata(BiodataModel biodataModel) async {
    final db = await database;
    var res = await db
        .query('biodata', where: 'id = ?', whereArgs: [biodataModel.id]);

    return res.isNotEmpty ? BiodataModel.fromJson(res.first) : null;
  }

  updateBioadata(BiodataModel biodataModel) async {
    final db = await database;
    var res = await db.update('biodata', biodataModel.toJson(),
        where: 'id = ?', whereArgs: [biodataModel.id]);

    return res;
  }

  newGallery(GalleryModel galleryModel) async {
    final db = await database;
    var res = await db.insert('gallery', galleryModel.toJson());

    return res;
  }

  getGallerys(int id) async {
    final db = await database;
    var res = await db.query('gallery', where: 'idUser = ?', whereArgs: [id]);
    List<GalleryModel> gallerys = res.isNotEmpty
        ? res.map((gallery) => GalleryModel.fromJson(gallery)).toList()
        : [];

    return gallerys;
  }
}
