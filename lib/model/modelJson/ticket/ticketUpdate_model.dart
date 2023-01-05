class ticketUpdate {
  bool success;
  String token;
  Data data;
  String message;

  ticketUpdate({this.success, this.token, this.data, this.message});

  ticketUpdate.fromJson(Map<String, dynamic> json) {
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
  int ticketId;
  int statusBefore;
  String statusAfter;
  String description;
  String supervisorId;
  String updatedAt;
  String createdAt;
  int id;
  Supervisor supervisor;

  Data(
      {this.ticketId,
        this.statusBefore,
        this.statusAfter,
        this.description,
        this.supervisorId,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.supervisor});

  Data.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    statusBefore = json['status_before'];
    statusAfter = json['status_after'];
    description = json['description'];
    supervisorId = json['supervisor_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    supervisor = json['supervisor'] != null
        ? new Supervisor.fromJson(json['supervisor'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['status_before'] = this.statusBefore;
    data['status_after'] = this.statusAfter;
    data['description'] = this.description;
    data['supervisor_id'] = this.supervisorId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    if (this.supervisor != null) {
      data['supervisor'] = this.supervisor.toJson();
    }
    return data;
  }
}

class Supervisor {
  String employeeId;
  String supervisorId;
  String deviceId;
  String employeeName;
  String employeeEmail;
  String employeeKtp;
  String employeeBirth;
  String apiToken;

  Supervisor(
      {this.employeeId,
        this.supervisorId,
        this.deviceId,
        this.employeeName,
        this.employeeEmail,
        this.employeeKtp,
        this.employeeBirth,
        this.apiToken});

  Supervisor.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    supervisorId = json['supervisor_id'];
    deviceId = json['device_id'];
    employeeName = json['employee_name'];
    employeeEmail = json['employee_email'];
    employeeKtp = json['employee_ktp'];
    employeeBirth = json['employee_birth'];
    apiToken = json['api_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    data['supervisor_id'] = this.supervisorId;
    data['device_id'] = this.deviceId;
    data['employee_name'] = this.employeeName;
    data['employee_email'] = this.employeeEmail;
    data['employee_ktp'] = this.employeeKtp;
    data['employee_birth'] = this.employeeBirth;
    data['api_token'] = this.apiToken;
    return data;
  }
}