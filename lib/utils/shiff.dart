// shift_utils.dart

// ignore_for_file: unused_import

import 'package:flutter/material.dart';

class ShiftUtils {
  static void adjustSelectedShiftTimes({
    required String? selectedShift,
    required DateTime? selectedShiftStartTime,
    required DateTime? selectedShiftEndTime,
  }) {
    switch (selectedShift) {
      case "Shiff 1 jam 08:00 - 17:00":
        selectedShiftStartTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          8,
          0,
          0,
        );
        selectedShiftEndTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          17,
          0,
          0,
        );
        break;
      case "Shiff 2 jam 08:30 - 17:30":
        selectedShiftStartTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          8,
          30,
          0,
        );
        selectedShiftEndTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          17,
          30,
          0,
        );
        break;
      case "Shiff 3 jam 09:00 - 18:00":
        selectedShiftStartTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          9,
          0,
          0,
        );
        selectedShiftEndTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          18,
          0,
          0,
        );
        break;
      case "Shiff 4 jam 19:00 - 10:00":
        selectedShiftStartTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          19,
          0,
          0,
        );
        selectedShiftEndTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          10,
          0,
          0,
        );
        break;
      case "Shiff 5 jam 10:00 - 10:08":
        selectedShiftStartTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          10,
          0,
          0,
        );
        selectedShiftEndTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          10,
          0,
          8,
        );
        break;
      // Add other cases as needed
    }
  }
}
