class pic {
  bool success;
  Null token;
  Data data;
  String message;

  pic({this.success, this.token, this.data, this.message});

  pic.fromJson(Map<String, dynamic> json) {
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
  List<PIC> pIC;

  Data({this.pIC});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['PIC '] != null) {
      pIC = <PIC>[];
      json['PIC '].forEach((v) {
        pIC.add(new PIC.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pIC != null) {
      data['PIC '] = this.pIC.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PIC {
  String employeeId;
  String employeeName;
  String supervisorId;
  // int employeeIdInt;
  // int supervisorIdInt;
  PIC({this.employeeId, this.employeeName, this.supervisorId});

  PIC.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    employeeName = json['employee_name'];
    supervisorId = json['supervisor_id'];
    // employeeIdInt = int.parse(employeeId);
    // supervisorIdInt = int.parse(supervisorIdInt);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    data['employee_name'] = this.employeeName;
    data['supervisor_id'] = this.supervisorId;
    return data;
  }
}