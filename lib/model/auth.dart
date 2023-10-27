class LoginResponseModel {
  final String? accessToken;
  final int? expiresIn;

  LoginResponseModel({this.accessToken, this.expiresIn});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['access_token'],
      expiresIn: json['expires_in'],
    );
  }
}
