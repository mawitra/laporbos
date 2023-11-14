// attendance_qr_model.dart
class AttendanceQRModel {
  final String locQR1;
  final String locQR2;
  final String custName;

  AttendanceQRModel({
    required this.locQR1,
    required this.locQR2,
    required this.custName,
  });

  factory AttendanceQRModel.fromJson(Map<String, dynamic> json) {
    return AttendanceQRModel(
      locQR1: json['Loc_QR1'],
      locQR2: json['Loc_QR2'],
      custName: json['Cust_Name'],
    );
  }
}
