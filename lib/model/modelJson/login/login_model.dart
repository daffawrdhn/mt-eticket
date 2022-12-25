class Login {
  bool success;
  String token;
  Data data;
  String message;

  Login({this.success, this.token, this.data, this.message});

  Login.fromJson(Map<String, dynamic> json) {
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
  String deviceId;
  String employeeName;
  String employeeEmail;
  String employeeKtp;
  String employeeBirth;
  String apiToken;
  Role role;
  Organization organization;
  Regional regional;

  Data(
      {this.employeeId,
        this.supervisorId,
        this.deviceId,
        this.employeeName,
        this.employeeEmail,
        this.employeeKtp,
        this.employeeBirth,
        this.apiToken,
        this.role,
        this.organization,
        this.regional});

  Data.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    supervisorId = json['supervisor_id'];
    deviceId = json['device_id'];
    employeeName = json['employee_name'];
    employeeEmail = json['employee_email'];
    employeeKtp = json['employee_ktp'];
    employeeBirth = json['employee_birth'];
    apiToken = json['api_token'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    organization = json['organization'] != null
        ? new Organization.fromJson(json['organization'])
        : null;
    regional = json['regional'] != null
        ? new Regional.fromJson(json['regional'])
        : null;
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
    if (this.role != null) {
      data['role'] = this.role.toJson();
    }
    if (this.organization != null) {
      data['organization'] = this.organization.toJson();
    }
    if (this.regional != null) {
      data['regional'] = this.regional.toJson();
    }
    return data;
  }
}

class Role {
  int roleId;
  String roleName;

  Role({this.roleId, this.roleName});

  Role.fromJson(Map<String, dynamic> json) {
    roleId = json['role_id'];
    roleName = json['role_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role_id'] = this.roleId;
    data['role_name'] = this.roleName;
    return data;
  }
}

class Organization {
  int organizationId;
  String orgainzationName;

  Organization({this.organizationId, this.orgainzationName});

  Organization.fromJson(Map<String, dynamic> json) {
    organizationId = json['organization_id'];
    orgainzationName = json['orgainzation_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['organization_id'] = this.organizationId;
    data['orgainzation_name'] = this.orgainzationName;
    return data;
  }
}

class Regional {
  int regionalId;
  String regionalName;

  Regional({this.regionalId, this.regionalName});

  Regional.fromJson(Map<String, dynamic> json) {
    regionalId = json['regional_id'];
    regionalName = json['regional_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['regional_id'] = this.regionalId;
    data['regional_name'] = this.regionalName;
    return data;
  }
}