class LoginModel {
  final String? accessToken;
  final int? expiresIn;

  LoginModel({this.accessToken, this.expiresIn});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      accessToken: json['access_token'],
      expiresIn: json['expires_in'],
    );
  }
}
