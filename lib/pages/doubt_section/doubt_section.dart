import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/doubt_section/contact_card.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/doubt_section/current_test_time.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class DoubtSection extends StatelessWidget {
  final String roomNumber;
  const DoubtSection({Key? key, required this.roomNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: white,
          statusBarIconBrightness: Brightness.dark,
        ),
        toolbarHeight: 175,
        flexibleSpace: Container(
          color: primaryColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 60.0, 101, 2),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Text(
                      'Doubt Section',
                      style: TextStyle(
                        fontSize: fontMedium,
                        fontWeight: FontWeight.bold,
                        color: white,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35),
                    child: Column(
                      children: [
                        Text(
                          "Room: $roomNumber",
                          style: const TextStyle(
                              fontSize: fontXLarge, color: Colors.white),
                        ),
                        const SizedBox(height: 2),
                        const CurrentTestTime(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // Make the body cover the entire screen
      body: SingleChildScrollView(
          child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 175,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 17, top: 15, bottom: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Contacts for help",
                  style: TextStyle(fontSize: fontMedium),
                ),
              ),
            ),
            ContactCard(
              name: 'Dr. Adirup Shankar',
              designation: 'Controller of Examination',
              onMessagePressed: () {
                // Handle message icon pressed for John Doe
              },
            ),
            ContactCard(
              name: 'Dr. Virender Singh',
              designation: 'CSEII2911- Computer Graphics',
              onMessagePressed: () {
                // Handle message icon pressed for Jane Smith
              },
            ),
            ContactCard(
              name: 'Mr. Teriyaki Khan',
              designation: 'CSEII2011- Micro-Services',
              onMessagePressed: () {
                // Handle message icon pressed for Bob Johnson
              },
            ),
            ContactCard(
              name: 'Mr. Sai Khanna',
              designation: 'Finance Department',
              onMessagePressed: () {
                // Handle message icon pressed for Alice Brown
              },
            ),
          ],
        ),
      )),
    );
  }
}
