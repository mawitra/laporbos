// ignore_for_file: unused_import

import 'package:laporbos/model/user.dart';

class AttendanceModel {
  final String attdID;
  final String custID;
  final String officerID;
  final String officerName;
  final String locQR;
  final String attdDate;
  final String status;
  final String attdPic;
  final String latitude;
  final String longitude;
  final String createDate;
  final String createBy;
  final String lastUpdate;
  final String lastUpdateBy;

  AttendanceModel({
    required this.attdID,
    required this.custID,
    required this.officerID,
    required this.officerName,
    required this.locQR,
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

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      attdID: json['Attd_ID'],
      custID: json['Cust_ID'],
      officerID: json['Officer_ID'],
      officerName: json['Officer_Name'],
      locQR: json['Loc_QR'],
      attdDate: json['Attd_Date'],
      status: json['Status'],
      attdPic: json['Attd_Pic'],
      latitude: json['Latitude'],
      longitude: json['Longitude'],
      createDate: json['Create_Date'],
      createBy: json['Create_By'],
      lastUpdate: json['Last_Update'],
      lastUpdateBy: json['Last_Update_By'],
    );
  }
}
