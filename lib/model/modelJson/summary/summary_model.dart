class summary {
  bool success;
  Null token;
  Data data;
  String message;

  summary({this.success, this.token, this.data, this.message});

  summary.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int open;
  int ap1;
  int ap2;
  int ap3;
  int completed;
  int rejected;
  int total;

  Data(
      {this.open, this.ap1, this.ap2, this.ap3, this.completed, this.rejected, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    open = json['open'];
    ap1 = json['ap1'];
    ap2 = json['ap2'];
    ap3 = json['ap3'];
    completed = json['completed'];
    rejected = json['rejected'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['open'] = this.open;
    data['ap1'] = this.ap1;
    data['ap2'] = this.ap2;
    data['ap3'] = this.ap3;
    data['completed'] = this.completed;
    data['rejected'] = this.rejected;
    data['total'] = this.total;
    return data;
  }
}