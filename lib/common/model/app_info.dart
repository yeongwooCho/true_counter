class AppInfo {
  static int currentVersion = 10000;
  static AppInfo? current;
  static List<AppInfo> all = [];

  late String id;
  late DateTime createdDt;
  late DateTime updatedDt;
  late String version;

  AppInfo.fromJson({
    required Map<String, dynamic> json,
  })  : id = json['id'],
        createdDt = DateTime.parse(json['createdDt']),
        updatedDt = DateTime.parse(json['updatedDt']),
        version = json['version'];
}
