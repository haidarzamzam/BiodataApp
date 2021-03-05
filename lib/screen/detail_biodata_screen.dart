import 'dart:convert';

import 'package:biodata_app/data/blocs/biodatas_bloc.dart';
import 'package:biodata_app/data/blocs/bloc_provider.dart';
import 'package:biodata_app/data/blocs/gallery_bloc.dart';
import 'package:biodata_app/data/models/biodata_model.dart';
import 'package:biodata_app/screen/edit_biodata_screen.dart';
import 'package:biodata_app/screen/gallery_screen.dart';
import 'package:biodata_app/screen/social_media_screen.dart';
import 'package:biodata_app/utils/toast_utils.dart';
import 'package:biodata_app/utils/widget.dart';
import 'package:biodata_app/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class DetailBiodataScreen extends StatefulWidget {
  final BiodataModel biodataModel;

  const DetailBiodataScreen({Key key, this.biodataModel}) : super(key: key);

  @override
  _DetailBiodataScreenState createState() => _DetailBiodataScreenState();
}

class _DetailBiodataScreenState extends State<DetailBiodataScreen> {
  BiodatasBloc _biodataBloc;
  BiodataModel _biodataModel;

  @override
  void initState() {
    super.initState();
    _biodataModel = widget.biodataModel;
    _biodataBloc = BlocProvider.of<BiodatasBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Detail Biodata",
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
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              _displayTextInputDialog(
                  context, _biodataModel.password, widget.biodataModel);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      bool update = await Navigator.of(context).push(
                        MaterialPageRoute(
                          // Once again, use the BlocProvider to pass the ViewNoteBloc
                          // to the ViewNotePage
                          builder: (context) => BlocProvider(
                            bloc: GalleryBloc(_biodataModel.id),
                            child: GalleryScreen(
                              idUser: _biodataModel.id,
                            ),
                          ),
                        ),
                      );

                      // If update was set, get all the notes again
                      if (update != null) {
                        _biodataBloc.getBiodatas();
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        base64Decode(_biodataModel.photoProfile),
                        fit: BoxFit.fill,
                        height: 220,
                        width: 150,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 222,
                    height: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _biodataModel.name + "\n\n\n",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 32, color: Colors.white),
                        ),
                        Text(
                          _biodataModel.gender,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () async {
                                  bool update =
                                      await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        bloc: BiodatasBloc(),
                                        child: SocialMediaScreen(
                                          url: _biodataModel.urlInstagram,
                                          type: "Instagram",
                                        ),
                                      ),
                                    ),
                                  );

                                  if (update != null) {
                                    _biodataBloc.getBiodatas();
                                  }
                                },
                                child: IconTile(
                                  backColor: Colors.white,
                                  imgAssetPath: "assets/images/ig.png",
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  bool update =
                                      await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        bloc: BiodatasBloc(),
                                        child: SocialMediaScreen(
                                          url: _biodataModel.urlFacebook,
                                          type: "Facebook",
                                        ),
                                      ),
                                    ),
                                  );

                                  if (update != null) {
                                    _biodataBloc.getBiodatas();
                                  }
                                },
                                child: IconTile(
                                  backColor: Colors.white,
                                  imgAssetPath: "assets/images/fb.png",
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  bool update =
                                      await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        bloc: BiodatasBloc(),
                                        child: SocialMediaScreen(
                                          url: _biodataModel.urlYoutube,
                                          type: "Youtube",
                                        ),
                                      ),
                                    ),
                                  );

                                  if (update != null) {
                                    _biodataBloc.getBiodatas();
                                  }
                                },
                                child: IconTile(
                                  backColor: Colors.white,
                                  imgAssetPath: "assets/images/yt.png",
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "About",
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Adress",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        "Email",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        "Phone",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ": ${_biodataModel.address}",
                        style: TextStyle(color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        ": ${_biodataModel.email}",
                        style: TextStyle(color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        ": ${_biodataModel.phoneNumber}",
                        style: TextStyle(color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconTile extends StatelessWidget {
  final String imgAssetPath;
  final Color backColor;

  IconTile({this.imgAssetPath, this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            color: backColor, borderRadius: BorderRadius.circular(8)),
        child: Image.asset(
          imgAssetPath,
          width: 20,
        ),
      ),
    );
  }
}

Future<void> _displayTextInputDialog(
    BuildContext context, String password, BiodataModel biodataModel) async {
  TextEditingController _fieldPasswordInput = TextEditingController();
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text('Input your password'),
        content:
            buildTextField(_fieldPasswordInput, "Password", TextInputType.text),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'CANCEL',
              style: TextStyle(color: WidgetUtil().parseHexColor("#db0000")),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text(
              'OK',
              style: TextStyle(color: WidgetUtil().parseHexColor("#db0000")),
            ),
            onPressed: () async {
              if (_fieldPasswordInput.text == password) {
                Navigator.pop(context);
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      bloc: BiodatasBloc(),
                      child: EditBiodataScreen(
                        photo: biodataModel.photoProfile,
                        name: biodataModel.name,
                        address: biodataModel.address,
                        phone: biodataModel.phoneNumber,
                        email: biodataModel.email,
                        urlInstagram: biodataModel.urlInstagram,
                        urlFacebook: biodataModel.urlFacebook,
                        urlYoutube: biodataModel.urlYoutube,
                        password: biodataModel.password,
                        id: biodataModel.id,
                      ),
                    ),
                  ),
                );
              } else {
                ToastUtils.show("Password wrong!");
              }
            },
          ),
        ],
      );
    },
  );
}
