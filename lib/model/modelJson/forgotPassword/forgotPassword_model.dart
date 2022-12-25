class forgotPassword {
  bool success;
  String token;
  int data;
  String message;

  forgotPassword({this.success, this.token, this.data, this.message});

  forgotPassword.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['token'] = this.token;
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }
}