import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LaporanController extends GetxController {

  TextEditingController dateController = TextEditingController();

  
  Future<void> pilihTanggal () async {
    var context;
    DateTime? pickedDate = await showDatePicker(
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101), context: context,
    );
    if (pickedDate != null) {
      String formattedDate =
      DateFormat('E, d MMM yyy HH:mm:ss').format(pickedDate);

      dateController.text = pickedDate.toString();
    }
    update();
  }
}