class SignUpRespModel {
  String? token;
  int? isPhoneVerified;
  String? phoneVerifyEndUrl;

  SignUpRespModel({this.token, this.isPhoneVerified, this.phoneVerifyEndUrl});

  SignUpRespModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    isPhoneVerified = json['is_phone_verified'];
    phoneVerifyEndUrl = json['phone_verify_end_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['is_phone_verified'] = this.isPhoneVerified;
    data['phone_verify_end_url'] = this.phoneVerifyEndUrl;
    return data;
  }
}
