

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sbbwu_navigator/widgets/custom_button.dart';

import '../../widgets/text_form_field.dart';

class AddDepartment extends StatefulWidget {
  const AddDepartment({Key? key}) : super(key: key);

  @override
  State<AddDepartment> createState() => _AddDepartmentState();
}

class _AddDepartmentState extends State<AddDepartment> {
  TextEditingController departmentName = TextEditingController();
  TextEditingController floorName = TextEditingController();
  TextEditingController departmentlongitude = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            title: "Department Name",
            keyboardType: TextInputType.text,
            controller: departmentName,
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            title: "latitude",
            keyboardType: TextInputType.number,
            controller: floorName,
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            title: "longitude",
            keyboardType: TextInputType.number,
            controller: departmentlongitude,
          ),
          SizedBox(
            height: 30,
          ),
          CustomButton(
            title: "Add",
            height: 50,
            onTap: (){
              FirebaseFirestore.instance.collection("department").add({
                "departmentName" : departmentName.text,
                "longitude" : departmentlongitude.text,
                "latitude" : floorName.text,
              });
            },
          ),
        ],
      ),
    );
  }
}
