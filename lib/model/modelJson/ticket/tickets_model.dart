class tickets {
  bool success;
  String token;
  List<Data> data;
  String message;

  tickets({this.success, this.token, this.data, this.message});

  tickets.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int ticketId;
  String employeeId;
  String supervisorId;
  int featureId;
  int subFeatureId;
  int ticketStatusId;
  String ticketTitle;
  String ticketDescription;
  String photo;
  String createdAt;
  String updatedAt;
  Employee employee;
  Employee supervisor;
  List<History> history;
  Feature feature;
  SubFeature subFeature;
  TicketStatus ticketStatus;

  Data(
      {this.ticketId,
        this.employeeId,
        this.supervisorId,
        this.featureId,
        this.subFeatureId,
        this.ticketStatusId,
        this.ticketTitle,
        this.ticketDescription,
        this.photo,
        this.createdAt,
        this.updatedAt,
        this.employee,
        this.supervisor,
        this.history,
        this.feature,
        this.subFeature,
        this.ticketStatus});

  Data.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    employeeId = json['employee_id'];
    supervisorId = json['supervisor_id'];
    featureId = json['feature_id'];
    subFeatureId = json['sub_feature_id'];
    ticketStatusId = json['ticket_status_id'];
    ticketTitle = json['ticket_title'];
    ticketDescription = json['ticket_description'];
    photo = json['photo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    employee = json['Employee'] != null
        ? new Employee.fromJson(json['Employee'])
        : null;
    supervisor = json['supervisor'] != null
        ? new Employee.fromJson(json['supervisor'])
        : null;
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history.add(new History.fromJson(v));
      });
    }
    feature =
    json['feature'] != null ? new Feature.fromJson(json['feature']) : null;
    subFeature = json['sub_feature'] != null
        ? new SubFeature.fromJson(json['sub_feature'])
        : null;
    ticketStatus = json['ticket_status'] != null
        ? new TicketStatus.fromJson(json['ticket_status'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['employee_id'] = this.employeeId;
    data['supervisor_id'] = this.supervisorId;
    data['feature_id'] = this.featureId;
    data['sub_feature_id'] = this.subFeatureId;
    data['ticket_status_id'] = this.ticketStatusId;
    data['ticket_title'] = this.ticketTitle;
    data['ticket_description'] = this.ticketDescription;
    data['photo'] = this.photo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.employee != null) {
      data['Employee'] = this.employee.toJson();
    }
    if (this.supervisor != null) {
      data['supervisor'] = this.supervisor.toJson();
    }
    if (this.history != null) {
      data['history'] = this.history.map((v) => v.toJson()).toList();
    }
    if (this.feature != null) {
      data['feature'] = this.feature.toJson();
    }
    if (this.subFeature != null) {
      data['sub_feature'] = this.subFeature.toJson();
    }
    if (this.ticketStatus != null) {
      data['ticket_status'] = this.ticketStatus.toJson();
    }
    return data;
  }
}

class Employee {
  String employeeId;
  String supervisorId;
  String deviceId;
  String employeeName;
  String employeeEmail;
  String employeeKtp;
  String employeeBirth;
  String apiToken;
  Organization organization;
  Regional regional;

  Employee(
      {this.employeeId,
        this.supervisorId,
        this.deviceId,
        this.employeeName,
        this.employeeEmail,
        this.employeeKtp,
        this.employeeBirth,
        this.apiToken,
        this.organization,
        this.regional});

  Employee.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    supervisorId = json['supervisor_id'];
    deviceId = json['device_id'];
    employeeName = json['employee_name'];
    employeeEmail = json['employee_email'];
    employeeKtp = json['employee_ktp'];
    employeeBirth = json['employee_birth'];
    apiToken = json['api_token'];
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
    if (this.organization != null) {
      data['organization'] = this.organization.toJson();
    }
    if (this.regional != null) {
      data['regional'] = this.regional.toJson();
    }
    return data;
  }
}

class Organization {
  int organizationId;
  String orgainzationName;
  String createdAt;
  String updatedAt;

  Organization(
      {this.organizationId,
        this.orgainzationName,
        this.createdAt,
        this.updatedAt});

  Organization.fromJson(Map<String, dynamic> json) {
    organizationId = json['organization_id'];
    orgainzationName = json['orgainzation_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['organization_id'] = this.organizationId;
    data['orgainzation_name'] = this.orgainzationName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Regional {
  int regionalId;
  String regionalName;
  String createdAt;
  String updatedAt;

  Regional(
      {this.regionalId, this.regionalName, this.createdAt, this.updatedAt});

  Regional.fromJson(Map<String, dynamic> json) {
    regionalId = json['regional_id'];
    regionalName = json['regional_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['regional_id'] = this.regionalId;
    data['regional_name'] = this.regionalName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class History {
  int id;
  int ticketId;
  int statusBefore;
  int statusAfter;
  String description;
  String supervisorId;
  String createdAt;
  String updatedAt;
  Employee supervisor;

  History(
      {this.id,
        this.ticketId,
        this.statusBefore,
        this.statusAfter,
        this.description,
        this.supervisorId,
        this.createdAt,
        this.updatedAt,
        this.supervisor});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticketId = json['ticket_id'];
    statusBefore = json['status_before'];
    statusAfter = json['status_after'];
    description = json['description'];
    supervisorId = json['supervisor_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    supervisor = json['supervisor'] != null
        ? new Employee.fromJson(json['supervisor'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticket_id'] = this.ticketId;
    data['status_before'] = this.statusBefore;
    data['status_after'] = this.statusAfter;
    data['description'] = this.description;
    data['supervisor_id'] = this.supervisorId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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

class Feature {
  int featureId;
  String featureName;
  String createdAt;
  String updatedAt;

  Feature({this.featureId, this.featureName, this.createdAt, this.updatedAt});

  Feature.fromJson(Map<String, dynamic> json) {
    featureId = json['feature_id'];
    featureName = json['feature_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feature_id'] = this.featureId;
    data['feature_name'] = this.featureName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class SubFeature {
  int subFeatureId;
  int featureId;
  String subFeatureName;
  String createdAt;
  String updatedAt;

  SubFeature(
      {this.subFeatureId,
        this.featureId,
        this.subFeatureName,
        this.createdAt,
        this.updatedAt});

  SubFeature.fromJson(Map<String, dynamic> json) {
    subFeatureId = json['sub_feature_id'];
    featureId = json['feature_id'];
    subFeatureName = json['sub_feature_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_feature_id'] = this.subFeatureId;
    data['feature_id'] = this.featureId;
    data['sub_feature_name'] = this.subFeatureName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class TicketStatus {
  int ticketStatusId;
  String ticketStatusName;
  String ticketStatusNext;
  String createdAt;
  String updatedAt;

  TicketStatus(
      {this.ticketStatusId,
        this.ticketStatusName,
        this.ticketStatusNext,
        this.createdAt,
        this.updatedAt});

  TicketStatus.fromJson(Map<String, dynamic> json) {
    ticketStatusId = json['ticket_status_id'];
    ticketStatusName = json['ticket_status_name'];
    ticketStatusNext = json['ticket_status_next'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_status_id'] = this.ticketStatusId;
    data['ticket_status_name'] = this.ticketStatusName;
    data['ticket_status_next'] = this.ticketStatusNext;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}