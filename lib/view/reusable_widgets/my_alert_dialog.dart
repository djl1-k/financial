// ignore_for_file: sort_child_properties_last, use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace

import 'package:financial_app/model/firestore.dart';
import 'package:financial_app/view/reusable_widgets/my_text_field.dart';
import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String? docId;
  final String title;
  final String buttonText;
  
  final descriptionController = TextEditingController();
  final financeController = TextEditingController();
  final fireStoreServices = FireStoreServices();

  MyAlertDialog(
    {this.docId, required this.title, required this.buttonText}
  ) {
    // if docId is not null, get the record, and fill the controllers with existing data (for update)
      if (docId != null) {
      fireStoreServices.getRecord(docId!).then((record) {
        Map<String, dynamic> data = record.data() as Map<String, dynamic>;
        descriptionController.text = data['description'];
        financeController.text = data['amount'].toString();
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Center(child: Text(title)),
        insetPadding: EdgeInsets.symmetric(vertical: 50),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 300,
                child: MyTextField(
                  hintText: "Description", obscureText: false, controller: descriptionController, maxLine: 10,
                )
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                child: MyTextField(
                  hintText: "Amount", obscureText: false, controller: financeController, maxLine: 10,
                )
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: (){
                    //if docId is not null, then the record exists, update the record
                    if (docId != null){
                      fireStoreServices.updateRecord(docId!, descriptionController.text, num.parse(financeController.text));
                    }
                    //else, the record is new, add new record
                    else{
                      fireStoreServices.addRecord(descriptionController.text, num.parse(financeController.text));
                    }
                    //clear the controllers
                    descriptionController.clear();
                    financeController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(buttonText),
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
                ),
              ),
            ],
          ),
        )
      );
  }
}
