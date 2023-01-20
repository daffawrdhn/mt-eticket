class depthead {
  bool success;
  Null token;
  Data data;
  String message;

  depthead({this.success, this.token, this.data, this.message});

  depthead.fromJson(Map<String, dynamic> json) {
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
  List<DEPTHEAD> dEPTHEAD;

  Data({this.dEPTHEAD});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['DEPTHEAD '] != null) {
      dEPTHEAD = <DEPTHEAD>[];
      json['DEPTHEAD '].forEach((v) {
        dEPTHEAD.add(new DEPTHEAD.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dEPTHEAD != null) {
      data['DEPTHEAD '] = this.dEPTHEAD.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DEPTHEAD {
  String employeeId;
  String employeeName;
  String supervisorId;

  DEPTHEAD({this.employeeId, this.employeeName, this.supervisorId});

  DEPTHEAD.fromJson(Map<String, dynamic> json) {
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