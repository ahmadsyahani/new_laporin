import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';

class Laporan extends StatefulWidget {
  const Laporan({Key? key}) : super(key: key);

  @override
  State<Laporan> createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {

  // Image Picker
  File? _image;
  final picker = ImagePicker();

  // Date Controller
  TextEditingController dateController = TextEditingController();

  // Get Gallery
  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("Tidak ada gambar yang dipilih");
      }
    });
  }

  // Get Camera
  Future getImageCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("Tidak ada gambar yang dipilih");
      }
    });
  }

  // State Date
  @override
  void initState() {
    super.initState();
    dateController.text = "";
  }

  void dialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Container(
              height: 120,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      getImageCamera();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.camera_alt_rounded),
                      title: Text("Kamera"),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      getImageGallery();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.photo_library_rounded),
                      title: Text("Galeri"),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Get.offAllNamed(Routes.HOME);
          },
        ),
        title: const Text('Laporan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  dialog(context);
                },
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .2,
                    width: MediaQuery.of(context).size.width * 1,
                    child: _image != null
                        ? ClipRRect(
                            child: Image.file(
                              _image!.absolute,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: 100,
                            height: 100,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.black45,
                            ),
                          ),
                  ),
                ),
              ),
              Form(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _namapelapor(),
                      const SizedBox(
                        height: 15,
                      ),
                      _teleponpelapor(),
                      const SizedBox(
                        height: 15,
                      ),
                      _lokasikejaidan(),
                      const SizedBox(
                        height: 15,
                      ),
                      _tanggalkejadian(),
                      const SizedBox(
                        height: 15,
                      ),
                      _deskripsilaporan(),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.send_rounded),
                    label: Text(
                      "Submit",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      fixedSize: const Size(150, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _namapelapor() {
    return TextField(
      autocorrect: false,
      decoration: const InputDecoration(
        labelText: "Nama Pelapor",
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _teleponpelapor() {
    return TextField(
      keyboardType: TextInputType.number,
      autocorrect: false,
      decoration: const InputDecoration(
        labelText: "No.Telp Pelapor",
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _lokasikejaidan() {
    return TextField(
      maxLines: 2,
      autocorrect: false,
      decoration: const InputDecoration(
        labelText: "Lokasi Kejadian",
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _tanggalkejadian() {
    return TextField(
        controller: dateController,
        autocorrect: false,
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.calendar_month_rounded),
          labelText: "Tanggal Kejadian",
          border: OutlineInputBorder(),
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null)
            setState(() {
              dateController.text =
                  DateFormat('MMMM-dd-yyyy').format(pickedDate);
            });
        });
  }

  Widget _deskripsilaporan() {
    return TextField(
      maxLines: 7,
      autocorrect: false,
      decoration: const InputDecoration(
        labelText: "Deskripsi Laporan",
        border: OutlineInputBorder(),
      ),
    );
  }
}
