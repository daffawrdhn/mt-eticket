class helpdesk {
  bool success;
  Null token;
  Data data;
  String message;

  helpdesk({this.success, this.token, this.data, this.message});

  helpdesk.fromJson(Map<String, dynamic> json) {
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
  List<HELPDESK> hELPDESK;

  Data({this.hELPDESK});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['HELPDESK '] != null) {
      hELPDESK = <HELPDESK>[];
      json['HELPDESK '].forEach((v) {
        hELPDESK.add(new HELPDESK.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hELPDESK != null) {
      data['HELPDESK '] = this.hELPDESK.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HELPDESK {
  String employeeId;
  String employeeName;
  String supervisorId;

  HELPDESK({this.employeeId, this.employeeName, this.supervisorId});

  HELPDESK.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    employeeName = json['employee_name'];
    supervisorId = json['supervisor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    data['employee_name'] = this.employeeName;
    data['supervisor_id'] = this.supervisorId;
    return data;
  }
}