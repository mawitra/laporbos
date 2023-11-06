class AttendanceQrModel {
  final String locQr1;
  final String locQr2;
  final String custName;

  AttendanceQrModel({
    required this.locQr1,
    required this.locQr2,
    required this.custName,
  });

  factory AttendanceQrModel.fromJson(Map<String, dynamic> json) {
    return AttendanceQrModel(
      locQr1: json['Loc_QR1'],
      locQr2: json['Loc_QR2'],
      custName: json['Cust_Name'],
    );
  }
}
