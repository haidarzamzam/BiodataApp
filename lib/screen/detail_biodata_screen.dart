import 'dart:convert';

import 'package:biodata_app/data/blocs/biodatas_bloc.dart';
import 'package:biodata_app/data/blocs/bloc_provider.dart';
import 'package:biodata_app/data/models/biodata_model.dart';
import 'package:biodata_app/screen/social_media_screen.dart';
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
            onPressed: () {},
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
                  Expanded(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(
                        base64Decode(_biodataModel.photoProfile),
                        fit: BoxFit.fill,
                        height: 220),
                  )),
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
                          _biodataModel.name,
                          style: TextStyle(fontSize: 32, color: Colors.white),
                        ),
                        Text(
                          _biodataModel.gender,
                          style: TextStyle(fontSize: 19, color: Colors.grey),
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
                      ),
                      Text(
                        ": ${_biodataModel.email}",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        ": ${_biodataModel.phoneNumber}",
                        style: TextStyle(color: Colors.grey),
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
