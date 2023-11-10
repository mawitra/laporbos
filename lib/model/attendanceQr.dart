// class AttendanceQrModel {
//   final String locQR1;
//   final String locQR2;
//   final String custName;

//   AttendanceQrModel({
//     required this.locQR1,
//     required this.locQR2,
//     required this.custName,
//   });

// ignore_for_file: non_constant_identifier_names

//   factory AttendanceQrModel.fromJson(Map<String, dynamic> json) {
//     return AttendanceQrModel(
//       locQR1: json['Loc_QR1'],
//       locQR2: json['Loc_QR2'],
//       custName: json['Cust_Name'],
//     );
//   }
// }
class AttendanceQrModel {
  final String? cust_name;
  final String? loc_QR1;
  final String? loc_QR2;

  AttendanceQrModel({this.cust_name, this.loc_QR1, this.loc_QR2});

  factory AttendanceQrModel.fromJson(Map<String, dynamic> json) {
    return AttendanceQrModel(
      cust_name: json['Cust_Name'],
      loc_QR1: json['loc_QR1'],
      loc_QR2: json['loc_QR2'],
    );
  }
}
