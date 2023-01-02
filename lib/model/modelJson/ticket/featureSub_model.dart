class featureSub {
  bool success;
  Null token;
  Data data;
  String message;

  featureSub({this.success, this.token, this.data, this.message});

  featureSub.fromJson(Map<String, dynamic> json) {
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
  List<Feature> feature;

  Data({this.feature});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['feature'] != null) {
      feature = <Feature>[];
      json['feature'].forEach((v) {
        feature.add(new Feature.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.feature != null) {
      data['feature'] = this.feature.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Feature {
  int featureId;
  String featureName;
  List<SubFeature> subFeature;

  Feature({this.featureId, this.featureName, this.subFeature});

  Feature.fromJson(Map<String, dynamic> json) {
    featureId = json['feature_id'];
    featureName = json['feature_name'];
    if (json['sub_feature'] != null) {
      subFeature = <SubFeature>[];
      json['sub_feature'].forEach((v) {
        subFeature.add(new SubFeature.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feature_id'] = this.featureId;
    data['feature_name'] = this.featureName;
    if (this.subFeature != null) {
      data['sub_feature'] = this.subFeature.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubFeature {
  int subFeatureId;
  String subFeatureName;

  SubFeature({this.subFeatureId, this.subFeatureName});

  SubFeature.fromJson(Map<String, dynamic> json) {
    subFeatureId = json['sub_feature_id'];
    subFeatureName = json['sub_feature_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_feature_id'] = this.subFeatureId;
    data['sub_feature_name'] = this.subFeatureName;
    return data;
  }
}