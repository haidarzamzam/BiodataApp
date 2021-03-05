import 'dart:convert';

import 'package:biodata_app/data/blocs/biodatas_bloc.dart';
import 'package:biodata_app/data/blocs/bloc_provider.dart';
import 'package:biodata_app/data/models/biodata_model.dart';
import 'package:biodata_app/utils/add_image.dart';
import 'package:biodata_app/utils/toast_utils.dart';
import 'package:biodata_app/utils/validate_helper.dart';
import 'package:biodata_app/utils/widget.dart';
import 'package:biodata_app/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class EditBiodataScreen extends StatefulWidget {
  final int id;
  final String photo;
  final String name;
  final String address;
  final String email;
  final String phone;
  final String urlInstagram;
  final String urlFacebook;
  final String urlYoutube;
  final String password;
  final String gender;

  const EditBiodataScreen(
      {Key key,
      this.id,
      this.photo,
      this.name,
      this.address,
      this.email,
      this.phone,
      this.urlInstagram,
      this.urlFacebook,
      this.urlYoutube,
      this.password,
      this.gender})
      : super(key: key);

  @override
  _EditBiodataScreenState createState() => _EditBiodataScreenState();
}

class _EditBiodataScreenState extends State<EditBiodataScreen> {
  BiodatasBloc _biodataBloc;
  final _dropdownGenderValues = ["Laki-laki", "Perempuan"];

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _urlInstagramController = TextEditingController();
  final _urlFacebookController = TextEditingController();
  final _urlYoutubeController = TextEditingController();
  final _passwordController = TextEditingController();
  String _gender = "";
  String _photoProfile = "";
  bool _isHidePassword = true;

  @override
  void initState() {
    super.initState();
    _biodataBloc = BlocProvider.of<BiodatasBloc>(context);
    _nameController.text = widget.name;
    _addressController.text = widget.address;
    _emailController.text = widget.email;
    _phoneController.text = widget.phone;
    _urlInstagramController.text = widget.urlInstagram;
    _urlFacebookController.text = widget.urlFacebook;
    _urlYoutubeController.text = widget.urlYoutube;
    _passwordController.text = widget.password;
    _photoProfile = widget.photo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Edit Biodata",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Open Sans",
                fontWeight: FontWeight.w500)),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                child: buildCircleAvatar(_photoProfile),
                onTap: () {
                  _showOptionsAddImage(context);
                },
              ),
              SizedBox(height: 16),
              buildTextField(_nameController, "Name", TextInputType.name),
              SizedBox(height: 8),
              buildDropdown(
                  context, "Choose gender", _gender, _dropdownGenderValues,
                  (value) {
                setState(() {
                  _gender = value;
                });
                return;
              }),
              SizedBox(height: 8),
              buildTextField(
                  _addressController, "Address", TextInputType.streetAddress),
              SizedBox(height: 8),
              buildTextField(
                  _emailController, "Email", TextInputType.emailAddress),
              SizedBox(height: 8),
              buildTextField(_phoneController, "Phone", TextInputType.phone),
              SizedBox(height: 8),
              buildTextField(
                  _urlInstagramController, "URL Instagram", TextInputType.url),
              SizedBox(height: 8),
              buildTextField(
                  _urlFacebookController, "URL Facebook", TextInputType.url),
              SizedBox(height: 8),
              buildTextField(
                  _urlYoutubeController, "URL Youtube", TextInputType.url),
              SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                autofocus: false,
                obscureText: _isHidePassword,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  fillColor: WidgetUtil().parseHexColor("#323232"),
                  hintText: 'Password',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isHidePassword = !_isHidePassword;
                      });
                    },
                    child: Icon(
                      _isHidePassword ? Icons.visibility_off : Icons.visibility,
                      color: _isHidePassword ? Colors.grey : Colors.red,
                    ),
                  ),
                  isDense: true,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.transparent ?? Color(0xFF000000),
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.transparent ?? Color(0xFF000000),
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.all(15.0),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 50,
                child: SizedBox.expand(
                  child: RaisedButton(
                    onPressed: () {
                      _editBiodata();
                    },
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(4),
                    ),
                    color: WidgetUtil().parseHexColor("#db0000"),
                    disabledColor: WidgetUtil().parseHexColor("#db0000"),
                    child: Text(
                      "Edit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        fontFamily: "Open Sans",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editBiodata() async {
    if (ValidateHelper.isEmpty(_photoProfile)) {
      ToastUtils.show("Please add photo!");
    } else if (ValidateHelper.isEmpty(_nameController.text)) {
      ToastUtils.show("Please fill name!");
    } else if (ValidateHelper.isEmpty(_gender)) {
      ToastUtils.show("Please choose gender!");
    } else if (ValidateHelper.isEmpty(_addressController.text)) {
      ToastUtils.show("Please fill address!");
    } else if (ValidateHelper.isEmpty(_emailController.text)) {
      ToastUtils.show("Please fill email!");
    } else if (ValidateHelper.isEmpty(_phoneController.text)) {
      ToastUtils.show("Please fill phone!");
    } else if (ValidateHelper.isEmpty(_urlInstagramController.text)) {
      ToastUtils.show("Please fill URL instagram!");
    } else if (ValidateHelper.isEmpty(_urlFacebookController.text)) {
      ToastUtils.show("Please fill URL facebook!");
    } else if (ValidateHelper.isEmpty(_urlYoutubeController.text)) {
      ToastUtils.show("Please fill URL Youtube!");
    } else if (ValidateHelper.isEmpty(_passwordController.text)) {
      ToastUtils.show("Please fill password!");
    } else {
      BiodataModel biodataModel = new BiodataModel(
          id: widget.id,
          name: _nameController.text,
          gender: _gender,
          address: _addressController.text,
          phoneNumber: _phoneController.text,
          email: _emailController.text,
          urlInstagram: _urlInstagramController.text,
          urlFacebook: _urlFacebookController.text,
          urlYoutube: _urlYoutubeController.text,
          photoProfile: _photoProfile,
          password: _passwordController.text);

      _biodataBloc.inSaveBiodata.add(biodataModel);
      ToastUtils.show("Edit bio success");
      Navigator.pop(context);
      Navigator.pop(context, true);
    }
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
                      Navigator.pop(context);
                      setState(() {
                        _photoProfile = base64Encode(file.readAsBytesSync());
                      });
                      return;
                    });
                  },
                ),
                ListTile(
                    onTap: () {
                      postImageGallery((file) {
                        Navigator.pop(context);
                        setState(() {
                          _photoProfile = base64Encode(file.readAsBytesSync());
                        });
                        return;
                      });
                    },
                    leading: Icon(Icons.photo_library),
                    title: Text("Choose from photo library"))
              ]));
        });
  }
}
