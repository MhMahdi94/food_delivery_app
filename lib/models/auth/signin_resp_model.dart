class SignInRespModel {
  String? token;
  bool? isPhoneVerified;

  SignInRespModel({this.token, this.isPhoneVerified});

  SignInRespModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    isPhoneVerified = json['is_phone_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['is_phone_verified'] = this.isPhoneVerified;
    return data;
  }
}
