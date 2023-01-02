class ticketAdd {
  bool success;
  String token;
  Data data;
  String message;

  ticketAdd({this.success, this.token, this.data, this.message});

  ticketAdd.fromJson(Map<String, dynamic> json) {
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
  String employeeId;
  String supervisorId;
  String featureId;
  String subFeatureId;
  String ticketTitle;
  String ticketDescription;
  int ticketStatusId;
  String photo;
  String updatedAt;
  String createdAt;
  int ticketId;

  Data(
      {this.employeeId,
        this.supervisorId,
        this.featureId,
        this.subFeatureId,
        this.ticketTitle,
        this.ticketDescription,
        this.ticketStatusId,
        this.photo,
        this.updatedAt,
        this.createdAt,
        this.ticketId});

  Data.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    supervisorId = json['supervisor_id'];
    featureId = json['feature_id'];
    subFeatureId = json['sub_feature_id'];
    ticketTitle = json['ticket_title'];
    ticketDescription = json['ticket_description'];
    ticketStatusId = json['ticket_status_id'];
    photo = json['photo'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    ticketId = json['ticket_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    data['supervisor_id'] = this.supervisorId;
    data['feature_id'] = this.featureId;
    data['sub_feature_id'] = this.subFeatureId;
    data['ticket_title'] = this.ticketTitle;
    data['ticket_description'] = this.ticketDescription;
    data['ticket_status_id'] = this.ticketStatusId;
    data['photo'] = this.photo;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['ticket_id'] = this.ticketId;
    return data;
  }
}