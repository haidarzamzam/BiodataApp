import 'dart:convert';

import 'package:biodata_app/data/blocs/biodatas_bloc.dart';
import 'package:biodata_app/data/blocs/bloc_provider.dart';
import 'package:biodata_app/data/models/biodata_model.dart';
import 'package:biodata_app/screen/add_biodata_screen.dart';
import 'package:biodata_app/screen/biodata_screen.dart';
import 'package:biodata_app/screen/detail_biodata_screen.dart';
import 'package:biodata_app/utils/navigator.dart';
import 'package:biodata_app/utils/toast_utils.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  BiodatasBloc _biodataBloc;

  @override
  void initState() {
    super.initState();
    _biodataBloc = BlocProvider.of<BiodatasBloc>(context);
  }

  _getRequestsAdd() async {
    _biodataBloc.getBiodatas();
    ToastUtils.show("Add Data Success!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("List Biodata",
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
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/addBiodata')
                  .then((val) => val ? _getRequestsAdd() : null);
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<List<BiodataModel>>(
                  stream: _biodataBloc.biodatas,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<BiodataModel>> snapshot) {
                    if (snapshot.hasData) {
                      List<BiodataModel> biodatas = snapshot.data;

                      return GridView.count(
                        primary: true,
                        crossAxisCount: 2,
                        children: List.generate(biodatas.length, (index) {
                          return GestureDetector(
                            onTap: () async {
                              bool update = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  // Once again, use the BlocProvider to pass the ViewNoteBloc
                                  // to the ViewNotePage
                                  builder: (context) => BlocProvider(
                                    bloc: BiodatasBloc(),
                                    child: DetailBiodataScreen(
                                      biodataModel: biodatas[index],
                                    ),
                                  ),
                                ),
                              );

                              // If update was set, get all the notes again
                              if (update != null) {
                                _biodataBloc.getBiodatas();
                              }
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  color: Colors.transparent,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                            child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.memory(
                                              base64Decode(
                                                  biodatas[index].photoProfile),
                                              width: 150,
                                              height: 300,
                                              fit: BoxFit.cover),
                                        )),
                                        SizedBox(height: 8),
                                        Center(
                                          child: Text(
                                            biodatas[index].name,
                                            maxLines: 1,
                                            softWrap: true,
                                            style:
                                                TextStyle(color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
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
}
