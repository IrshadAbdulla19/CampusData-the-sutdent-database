import 'dart:io';

import 'package:bloc_student_database/data/db/db_funtions.dart';
import 'package:bloc_student_database/data/model/student_model.dart';
import 'package:bloc_student_database/domain/ImagePicking/image_picking_bloc.dart';
import 'package:bloc_student_database/presentetion/main_page/main_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class StudentAddingPage extends StatelessWidget {
  StudentAddingPage({super.key});
  String? imgPath;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.withOpacity(0.5),
        automaticallyImplyLeading: false,
        title: const Text("Add students"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: BlocBuilder<ImagePickingBloc, ImagePickingState>(
                    builder: (context, state) {
                      return CircleAvatar(
                          radius: 120,
                          backgroundImage: imgPath == null
                              ? const AssetImage(
                                      "asset/images/hd-man-user-illustration-icon-transparent-png-11640168385tqosatnrny.png")
                                  as ImageProvider
                              : FileImage(
                                  File(state.image),
                                ));
                    },
                  ),
                ),
                Positioned(
                  right: 80,
                  bottom: 10,
                  child: IconButton(
                      iconSize: 35,
                      onPressed: () async {
                        await takePhoto();
                        context
                            .read<ImagePickingBloc>()
                            .add(ChangeImg(image: imgPath ?? ""));
                      },
                      icon: Icon(Icons.camera_alt_outlined)),
                )
              ],
            ),
            formField(
                nameController, "Name", Icons.abc, TextInputType.name, 50),
            formField(
                ageController, "Age", Icons.place, TextInputType.number, 2),
            formField(
                phoneController, "Phone", Icons.phone, TextInputType.phone, 10),
            ElevatedButton(
                onPressed: () {
                  if (imgPath != null &&
                      nameController.text.isNotEmpty &&
                      phoneController.text.isNotEmpty &&
                      ageController.text.isNotEmpty) {
                    // studentAddSnackBar();

                    onAddStudentButtonClicked(context);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (ctx) => MainScreen()),
                        (route) => false);
                  } else {
                    showSnackBar(context);
                  }
                },
                child: const Text("Submit"))
          ],
        ),
      ),
    );
  }

  Padding formField(TextEditingController controlle, String hint, IconData icon,
      TextInputType input, length) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        maxLength: length,
        keyboardType: input,
        controller: controlle,
        decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
                // borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: Icon(
              icon,
              color: const Color.fromARGB(255, 20, 136, 82),
            )),
      ),
    );
  }

  Future<void> takePhoto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imgPath = pickedFile.path;
    }
  }

  Future<void> onAddStudentButtonClicked(BuildContext context) async {
    final _name = nameController.text.trim();
    final _age = ageController.text.trim();
    final _number = phoneController.text.trim();

    if (_name.isEmpty || _age.isEmpty || _number.isEmpty || imgPath == null) {
      return;
    }

    final student = StudentModel(
      name: _name,
      age: _age,
      phone: _number,
      imagePath: imgPath!,
    );

    addStudents(student, context).then((val) => studentAddSnackBar(context));
  }

  showSnackBar(BuildContext context) {
    var _errMsg = "";

    if (imgPath == null &&
        nameController.text.isEmpty &&
        ageController.text.isEmpty &&
        phoneController.text.isEmpty) {
      _errMsg = "Please Insert Valid Data In All Fields ";
    } else if (imgPath == null) {
      _errMsg = "please choose profile pic to Continue";
    } else if (ageController.text.isEmpty) {
      _errMsg = "Please enter the age to Continue";
    } else if (nameController.text.isEmpty) {
      _errMsg = "Name  Must Be Filled";
    } else if (phoneController.text.isEmpty) {
      _errMsg = "Phone Number Must Be Filled";
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(10.0),
        content: Text(_errMsg),
      ),
    );
  }

  void studentAddSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(255, 132, 110, 170),
        content: Text('This Student Inserted Into Database'),
      ),
    );
  }
}
