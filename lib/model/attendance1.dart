// class AttendanceData {
//   String attendanceId;
//   String customerId;
//   String officerId;
//   String officerName;
//   String locationQR;
//   String attendanceDate;
//   String status;
//   String attendancePic;
//   String latitude;
//   String longitude;
//   String createDate;
//   String createBy;
//   String lastUpdate;
//   String lastUpdateBy;

//   AttendanceData({
//     required this.attendanceId,
//     required this.customerId,
//     required this.officerId,
//     required this.officerName,
//     required this.locationQR,
//     required this.attendanceDate,
//     required this.status,
//     required this.attendancePic,
//     required this.latitude,
//     required this.longitude,
//     required this.createDate,
//     required this.createBy,
//     required this.lastUpdate,
//     required this.lastUpdateBy,
//   // });

// ignore_for_file: unused_import

//   factory AttendanceData.fromJson(Map<String, dynamic> json) {
//     return AttendanceData(
//       attendanceId: json['Attd_ID'] ?? "",
//       customerId: json['Cust_ID'] ?? "",
//       officerId: json['Officer_ID'] ?? "",
//       officerName: json['Officer_Name'] ?? "",
//       locationQR: json['Loc_QR'] ?? "",
//       attendanceDate: json['Attd_Date'] ?? "",
//       status: json['Status'] ?? "",
//       attendancePic: json['Attd_Pic'] ?? "",
//       latitude: json['Latitude'] ?? "",
//       longitude: json['Longitude'] ?? "",
//       createDate: json['Create_Date'] ?? "",
//       createBy: json['Create_By'] ?? "",
//       lastUpdate: json['Last_Update'] ?? "",
//       lastUpdateBy: json['Last_Update_By'] ?? "",
//     );
//   }
// }
import 'package:flutter/material.dart';

class Shift {
  final String name;
  final DateTime startTime;
  final DateTime endTime;

  Shift({required this.name, required this.startTime, required this.endTime});
}
