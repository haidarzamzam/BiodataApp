class BiodataModel {
  int id;
  String name;
  String gender;
  String address;
  String phoneNumber;
  String email;
  String urlInstagram;
  String urlFacebook;
  String urlYoutube;
  String photoProfile;
  String password;

  BiodataModel({
    this.id,
    this.name,
    this.gender,
    this.address,
    this.phoneNumber,
    this.email,
    this.urlInstagram,
    this.urlFacebook,
    this.urlYoutube,
    this.photoProfile,
    this.password,
  });

  factory BiodataModel.fromJson(Map<String, dynamic> json) => new BiodataModel(
        id: json["id"],
        name: json["name"],
        gender: json["gender"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        urlInstagram: json["urlInstagram"],
        urlFacebook: json["urlFacebook"],
        urlYoutube: json["urlYoutube"],
        photoProfile: json["photoProfile"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "gender": gender,
        "address": address,
        "phoneNumber": phoneNumber,
        "email": email,
        "urlInstagram": urlInstagram,
        "urlFacebook": urlFacebook,
        "urlYoutube": urlYoutube,
        "photoProfile": photoProfile,
        "password": password,
      };
}
