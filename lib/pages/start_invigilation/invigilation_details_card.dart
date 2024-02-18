import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class InvigilationDetailsCard extends StatelessWidget {
  final Map<dynamic, dynamic> data;
  const InvigilationDetailsCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> subjectCounts = {};
    final studentCount = data['room']['students'].length;
    int debarredCount = 0;

    for (var student in data['room']['students']) {
      if (!(student['eligible'] == 'YES')) {
        print(student['eligible']);
        debarredCount++;
      }
      if (!subjectCounts.containsKey(student['subject'])) {
        subjectCounts[student['subject']] = {};
        subjectCounts[student['subject']]['count'] = 1;
        subjectCounts[student['subject']]['course'] = student['course'];
      } else {
        subjectCounts[student['subject']]['count'] += 1;
      }
    }

    List<Widget> makeSubjectList() {
      List<Widget> list = [];
      for (int index = 0; index < subjectCounts.length; index++) {
        String subject = subjectCounts.keys.elementAt(index);
        int count = subjectCounts[subject]['count'];
        String course = subjectCounts[subject]['course'];
        list.add(Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: blueXLight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  color: blue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      course,
                      style: const TextStyle(color: white, fontSize: fontSmall),
                    ),
                    Container(
                      width: 25,
                      height: 25,
                      decoration: const BoxDecoration(
                        color: white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          count.toString(),
                          style: const TextStyle(
                            color: blue,
                            fontSize: fontSmall,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(subject,
                    style: const TextStyle(
                      color: blue,
                      fontSize: fontMedium,
                    )),
              ),
            ],
          ),
        ));
      }
      return list;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Invigilation Details:',
              style: TextStyle(
                  fontSize: fontLarge,
                  fontWeight: FontWeight.bold,
                  color: blue)),
          const SizedBox(height: 20),
          const Center(
              child: Text('Room No.', style: TextStyle(fontSize: fontMedium))),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              decoration: BoxDecoration(
                color: orange,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                data['room']['room_no'].toString(),
                style: const TextStyle(
                  color: white,
                  fontWeight: FontWeight.bold,
                  fontSize: fontMedium,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Examination Subjects'),
          ...makeSubjectList(),
          const SizedBox(height: 20),
          const Text('Co-Invigilator'),
          Text(
              data['invigilator'].runtimeType == String
                  ? 'Not Assigned'
                  : data['invigilator1']['name'],
              style: const TextStyle(
                fontSize: fontMedium,
                color: orange,
              )),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Students'),
              Text('Debarred Students'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(studentCount.toString(),
                  style: const TextStyle(
                    fontSize: fontMedium,
                    color: orange,
                  )),
              Text(debarredCount.toString(),
                  style: const TextStyle(
                    fontSize: fontMedium,
                    color: orange,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
