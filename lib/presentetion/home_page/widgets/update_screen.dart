import 'dart:io';

import 'package:bloc_student_database/data/db/db_funtions.dart';
import 'package:bloc_student_database/data/model/student_model.dart';
import 'package:bloc_student_database/domain/ImagePicking/image_picking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UpdateScreen extends StatelessWidget {
  UpdateScreen({super.key, required this.indx, required this.student});
  StudentModel student;
  final int indx;
  String? imgPath;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final image = student.imagePath;
    nameController.text = student.name;
    ageController.text = student.age;
    phoneController.text = student.phone;
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
                          ? FileImage(File(image))
                          : FileImage(File(imgPath ?? image)),
                    );
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
              nameController,
              // state.studentList?[indx].name ?? "name",
              Icons.abc,
              TextInputType.name,
              50),
          formField(
              ageController,
              // state.studentList?[indx].place ?? "Place",
              Icons.place,
              TextInputType.number,
              2),
          formField(
              phoneController,
              // state.studentList?[indx].phone ?? "Phone",
              Icons.phone,
              TextInputType.phone,
              10),
          ElevatedButton(
              onPressed: () {
                studentAdd(indx, image, context);

                Navigator.pop(context);
              },
              child: const Text("Update"))
        ],
      )),
    );
  }

  Padding formField(TextEditingController controlle, IconData icon,
      TextInputType input, int length) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        maxLength: length,
        keyboardType: input,
        controller: controlle,
        decoration: InputDecoration(
            // hintText: hint,
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

  Future<void> studentAdd(int index, imagePath, BuildContext context) async {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final phone = phoneController.text.trim();
    final image = imgPath;
    if (name.isEmpty || age.isEmpty || phone.isEmpty) {
      return;
    }

    StudentModel student = StudentModel(
      name: name,
      phone: phone,
      age: age,
      imagePath: image ?? imagePath,
    );

    updateStudents(index, context, student);
  }
}
