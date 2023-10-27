import 'package:laporbos/model/attendance.dart';
import 'package:laporbos/service/attendance.dart';

class AttendanceHandler {
  final AttendanceService _attendanceService;

  AttendanceHandler(
      this._attendanceService); // Konstruktor menerima _attendanceService

  // Future<List<Attendance>> getAttendanceByUser(
  //     String officerID, String token) async {
  //   try {
  //     return await _attendanceService.getAttendanceByUser(officerID, token);
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}
