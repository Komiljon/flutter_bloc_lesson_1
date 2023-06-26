import 'dart:convert';

import 'package:http/http.dart' as http;

class OfficesList {
  List<Office> offices;
  OfficesList({required this.offices});

  factory OfficesList.fromJson(Map<String, dynamic> json) {
    var officesJson = json['offices'] as List;

    List<Office> officesList = officesJson.map((i) => Office.fromJson(i)).toList();

    return OfficesList(
      offices: officesList,
    );
  }
}

class Office {
  final String name;
  final String address;
  final String schedule;
  final String phone;
  final String phoneto;

  Office({required this.name, required this.address, required this.schedule, required this.phone, required this.phoneto});

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
        name: json['name'] as String,
        address: json['address'] as String,
        schedule: json['schedule'] as String,
        phone: json['phone'] as String,
        phoneto: json['phoneto'] as String);
  }
}

Future<OfficesList> getOfficesList({String q = ''}) async {
  var url = 'https://aptechestvo.ru/api/v1/apteki/apteki_list.php?&query=$q';
  final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));

  if (response.statusCode == 200) {
    return OfficesList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
