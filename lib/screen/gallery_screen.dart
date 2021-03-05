import 'dart:convert';

import 'package:biodata_app/data/blocs/bloc_provider.dart';
import 'package:biodata_app/data/blocs/gallery_bloc.dart';
import 'package:biodata_app/data/models/gallery_model.dart';
import 'package:biodata_app/utils/add_image.dart';
import 'package:flutter/material.dart';

class GalleryScreen extends StatefulWidget {
  final int idUser;

  const GalleryScreen({Key key, this.idUser}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  GalleryBloc _galleryBloc;

  @override
  void initState() {
    super.initState();
    _galleryBloc = BlocProvider.of<GalleryBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Gallery",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Open Sans",
                fontWeight: FontWeight.w500)),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_photo_alternate_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              _showOptionsAddImage(context);
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<List<GalleryModel>>(
                  stream: _galleryBloc.gallerys,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<GalleryModel>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isEmpty) {
                        return Center(
                            child: Text("No data yet, Please add image!",
                                style: TextStyle(color: Colors.white)));
                      }
                      List<GalleryModel> gallerys = snapshot.data;

                      return GridView.count(
                        primary: true,
                        crossAxisCount: 3,
                        children: List.generate(gallerys.length, (index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: Colors.transparent,
                            child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                      child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.memory(
                                        base64Decode(gallerys[index].photo),
                                        width: 150,
                                        height: 300,
                                        fit: BoxFit.cover),
                                  )),
                                  SizedBox(height: 8),
                                ],
                              ),
                            ),
                          );
                        }),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionsAddImage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 150,
              child: Column(children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text("Take a picture from camera"),
                  onTap: () {
                    postImageCamera((file) {
                      GalleryModel galleryModel = new GalleryModel(
                        idUser: widget.idUser,
                        photo: base64Encode(file.readAsBytesSync()),
                      );

                      _galleryBloc.inAddGalery.add(galleryModel);
                      _galleryBloc.getGallery(widget.idUser);
                      Navigator.pop(context);
                      return;
                    });
                  },
                ),
                ListTile(
                    onTap: () {
                      postImageGallery((file) {
                        GalleryModel galleryModel = new GalleryModel(
                          idUser: widget.idUser,
                          photo: base64Encode(file.readAsBytesSync()),
                        );
                        _galleryBloc.inAddGalery.add(galleryModel);
                        _galleryBloc.getGallery(widget.idUser);
                        Navigator.pop(context);
                        return;
                      });
                    },
                    leading: Icon(Icons.photo_library),
                    title: Text("Choose from photo library"))
              ]));
        });
  }
}
