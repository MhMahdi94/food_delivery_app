class SignUpModel {
  String? name;
  String? email;
  String? mobileNo;
  String? address;
  String? password;

  SignUpModel({
    this.name,
    this.email,
    this.mobileNo,
    this.address,
    this.password,
  });

  SignUpModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobileNo = json['phone'];
    address = json['address'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['f_name'] = name;
    data['email'] = email;
    data['phone'] = mobileNo;
    data['address'] = address;
    data['password'] = password;
    return data;
  }
}
