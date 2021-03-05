class GalleryModel {
  int id;
  int idUser;
  String photo;

  GalleryModel({
    this.id,
    this.idUser,
    this.photo,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) => new GalleryModel(
        id: json["id"],
        idUser: json["idUser"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idUser": idUser,
        "photo": photo,
      };
}
