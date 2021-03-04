import 'package:biodata_app/data/blocs/biodatas_bloc.dart';
import 'package:biodata_app/data/blocs/bloc_provider.dart';
import 'package:biodata_app/data/models/biodata_model.dart';
import 'package:biodata_app/screen/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  BiodatasBloc _biodataBloc;

  @override
  void initState() {
    super.initState();
    _biodataBloc = BlocProvider.of<BiodatasBloc>(context);
  }

  void _navigateToBiodata(BiodataModel biodataModel) async {
    bool update = await Navigator.of(context).push(
      MaterialPageRoute(
        // Once again, use the BlocProvider to pass the ViewNoteBloc
        // to the ViewNotePage
        builder: (context) => BlocProvider(
          bloc: BiodatasBloc(),
          child: HomeScreen(),
        ),
      ),
    );

    if (update != null) {
      _biodataBloc.getBiodatas();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      if (snapshot.data.length == 0) {
                        return Text('No datas');
                      }

                      List<BiodataModel> biodatas = snapshot.data;

                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          BiodataModel biodata = biodatas[index];

                          return GestureDetector(
                            onTap: () {
                              _navigateToBiodata(biodata);
                            },
                            child: Container(
                              height: 40,
                              child: Text(
                                'Bioadata ' + biodata.id.toString(),
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          );
                        },
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
