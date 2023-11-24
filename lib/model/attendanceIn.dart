// attendance_model.dart

class AttendanceInModel {
  final String attdId;
  final String custId;
  final String officerId;
  final String officerName;
  final String locQr;
  final DateTime attdDate;
  final String status;
  final String attdPic;
  final double latitude;
  final double longitude;
  final DateTime createDate;
  final String createBy;
  final DateTime lastUpdate;
  final String lastUpdateBy;

  AttendanceInModel({
    required this.attdId,
    required this.custId,
    required this.officerId,
    required this.officerName,
    required this.locQr,
    required this.attdDate,
    required this.status,
    required this.attdPic,
    required this.latitude,
    required this.longitude,
    required this.createDate,
    required this.createBy,
    required this.lastUpdate,
    required this.lastUpdateBy,
  });

  factory AttendanceInModel.fromJson(Map<String, dynamic> json) {
    return AttendanceInModel(
      attdId: json['Attd_ID'],
      custId: json['Cust_ID'],
      officerId: json['Officer_ID'],
      officerName: json['Officer_Name'],
      locQr: json['Loc_QR'],
      attdDate: DateTime.parse(json['Attd_Date']),
      status: json['Status'],
      attdPic: json['Attd_Pic'],
      latitude: json['Latitude'],
      longitude: json['Longitude'],
      createDate: DateTime.parse(json['Create_Date']),
      createBy: json['Create_By'],
      lastUpdate: DateTime.parse(json['Last_Update']),
      lastUpdateBy: json['Last_Update_By'],
    );
  }
}
