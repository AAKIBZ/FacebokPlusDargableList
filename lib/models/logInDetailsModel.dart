class LogInDetailsModel {
  final String? email;
  final String? id;
  final String? name;
  final PictureDetailsModel? pictureDetailsModel;

  const LogInDetailsModel(
      {this.email, this.id, this.name, this.pictureDetailsModel});

  factory LogInDetailsModel.fromJson(
          Map<String, dynamic> jsonDataForLoginDetailsModel) =>
      LogInDetailsModel(
          email: jsonDataForLoginDetailsModel['email'],
          id: jsonDataForLoginDetailsModel['id'],
          name: jsonDataForLoginDetailsModel['name'],
          pictureDetailsModel: PictureDetailsModel.fromJson(
              jsonDataForLoginDetailsModel['picture']['data']));
}

class PictureDetailsModel {
  final String? url;
  final int? width;
  final int? height;

  const PictureDetailsModel({this.url, this.width, this.height});

  factory PictureDetailsModel.fromJson(
          Map<String, dynamic> jsonDataForPictureModel) =>
      PictureDetailsModel(
          url: jsonDataForPictureModel['url'],
          width: jsonDataForPictureModel['width'],
          height: jsonDataForPictureModel['height']);
}
