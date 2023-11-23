// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace, prefer_interpolation_to_compose_strings

import "package:cloud_firestore/cloud_firestore.dart";
import 'package:financial_app/view/reusable_widgets/my_alert_dialog.dart';
import 'package:financial_app/model/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final descriptionController = TextEditingController();
  final financeController = TextEditingController();
  final fireStoreServices = FireStoreServices();
  final user = FirebaseAuth.instance.currentUser!;

  // Dialog Box for adding expense
  void openDialogBox({String? docId, required bool editing}){
    String title = editing ? 'Edit record': 'Add new record';
    String buttonText = editing? 'Update record': 'Add record';

    showDialog(
      context: context,
      builder: (context) => Center(
        child: MyAlertDialog(docId: docId, title: title, buttonText: buttonText,),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Finance Tracker', 
          style: TextStyle(color: Colors.black),
          ), 
        backgroundColor: Colors.white, elevation: 0,),

      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            DrawerHeader(
              child: Icon(
                Icons.account_circle_sharp,
                size: 80,),
              ),
            Text(user.email!, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 20),
              child: ListTile(
                leading: Icon(Icons.wallet, color: Colors.black, size: 26,),
                title: Text('A D D  R E C O R D', style: TextStyle(fontSize: 18),),
                onTap: () {
                  Navigator.pop(context);
                  openDialogBox(editing: false);
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: ListTile(
                leading: Icon(Icons.arrow_back_rounded, color: Colors.black, size: 26,),
                title: Text('L O G O U T', style: TextStyle(fontSize: 18),),
                onTap: () => FirebaseAuth.instance.signOut(),
              ),
            )
          ],

        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: (){
          openDialogBox(editing: false);
        },
        child: const Icon(Icons.add, color: Colors.black,)
        ),
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),

                // Total balance
                StreamBuilder<QuerySnapshot>(
                  stream: fireStoreServices.getRecordStream(), 
                  builder: (context, snapshot) {
                    num totalAmount = 0;

                    // if we have data
                    if(snapshot.hasData){
                      List recordList = snapshot.data!.docs;
                      
                      // Calculate total amount
                      for (var doc in recordList) {
                        totalAmount += doc['amount'];
                      }

                      // Sign and color control for amount
                      // + and green for positive, - and red for negative
                      String sign = '';
                      Color color = Colors.black;
                      if (totalAmount > 0){
                        sign = '+';
                        color = Colors.green;
                      }
                      else if (totalAmount < 0){
                        sign = '-';
                        color = Colors.red;
                      }

                      // total amount container
                      return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                       
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      'Total Amount:', 
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                      ),
                                    SizedBox(height: 3),
                                    Text(
                                      '$sign\$${totalAmount.abs().toStringAsFixed(2)}',
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                      );
                      } 
                      else {
                        // Display a loading indicator while waiting for data
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                // Record display
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: fireStoreServices.getRecordStream(), 
                    builder: (context, snapshot) {

                      // if we have data
                      if(snapshot.hasData){
                        List recordList = snapshot.data!.docs;
                        // Display as a list
                        return ListView.builder(
                            itemCount: recordList.length,
                            itemBuilder: (context, index){
                              // get each document (row)
                              DocumentSnapshot document = recordList[index];
                              String docId = document.id;
                        
                              // get data from each column
                              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                              String title = data['description'];
                              num amount = data['amount'];
                              Timestamp timestamp = data['timestamp'];

                              String sign = '';
                              Color color = Colors.white;
                              if(amount > 0){
                                sign = '+';
                                color = Colors.green;
                              }
                              else if (amount < 0){
                                sign = '-';
                                color = Colors.red;
                              }
                              // display with a list tile
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  contentPadding: EdgeInsets.all(14),
                                  tileColor: Colors.white,
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          title, 
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: IconButton(
                                              onPressed: () => openDialogBox(
                                                editing: true,
                                                docId: docId
                                                ),
                                                icon: Icon(Icons.edit, color: Colors.black,), splashRadius: 30,)
                                            ),
                                          SizedBox(
                                            height:40,
                                            width: 40,
                                            child: IconButton(onPressed: () => fireStoreServices.deleteRecord(docId), icon: Icon(Icons.delete, color: Colors.black,), splashRadius: 30,)
                                          )
                                        ],
                                      )                                        
                                    ],
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          //timestamp
                                          DateFormat('yyyy-MM-dd').format(timestamp.toDate()),
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black
                                          ),
                                        ),
                                      Text('$sign\$${amount.abs()}', style: TextStyle(fontSize: 18,color: color, fontWeight: FontWeight.bold),), // Displaying expense with a label                                        
                                    ],
                                  ),
                                ),
                              );
                            },
                        );
                      }
                      else {
                        return Text("No Data");
                      }
                    },
                  ),
                ),
              ]
            ),
        ),
    );
  }
}