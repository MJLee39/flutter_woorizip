import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ZipRegistration extends GetxController {
  late String location = '';
  late String estate = '';
  late String attachments = '';
  late int total_floor = 0;
  late int building_floor = 0;
  late String image = '';
  late int deposit = 0;
  late int fee = 0;
  late DateTime checked_at = DateTime.now();
  late String direction = '';
  late String buildingType = '';
  late double m2 = 0;
  late int room = 0;
  late int toilet = 0;
  late DateTime moveInDate = DateTime.now();
  late String hashtag = '';
  late RxString showYes = 'public'.obs;
  late String note = '';
  late DateTime available = DateTime.now();
  late double maintenance_fee = 0;
  late DateTime premium = DateTime.now();

  final RxBool isLoading = true.obs;
  final RxList<Map<String, dynamic>> jsonData = <Map<String, dynamic>>[].obs;
  final RxString error = ''.obs;

  // Method to set arguments
  void setArguments(Map<String, dynamic> args) {
    location = args['selectedAddress'] ?? '';
    estate = (args['selectedAddress'] ?? '') + (args['selectedDong'] ?? '') + (args['selectedFloor'] ?? '') + (args['selectedHo'] ?? '');
    total_floor = args['totalFloor'] ?? 0;
    building_floor = int.tryParse(args['selectedFloor'].split('층').first) ?? 0;

  }

  @override
  void onInit() {
    super.onInit();
  }

  void updateValues({
    String? location,
    String? estate,
    String? attachments,
    int? totalFloor,
    int? deposit,
    int? fee,
    double? maintenanceFee,
    String? buildingType,
    String? direction,
    DateTime? moveInDate,
    int? room,
    int? toilet,
    double? m2,
    DateTime? checkedAt,
    String? note,
    String? showYes,
    String? hashtag,
    int? building_floor,
    DateTime? premium
  }) {
    this.location = location ?? this.location;
    this.estate = estate ?? this.estate;
    this.attachments = attachments ?? this.attachments;
    this.total_floor = totalFloor ?? this.total_floor;
    this.deposit = deposit ?? this.deposit;
    this.fee = fee ?? this.fee;
    this.maintenance_fee = maintenanceFee ?? this.maintenance_fee;
    this.buildingType = buildingType ?? this.buildingType;
    this.direction = direction ?? this.direction;
    this.moveInDate = moveInDate ?? this.moveInDate;
    this.room = room ?? this.room;
    this.toilet = toilet ?? this.toilet;
    this.m2 = m2 ?? this.m2;
    this.checked_at = checkedAt ?? this.checked_at;
    this.note = note ?? this.note;
    this.showYes.value = showYes ?? this.showYes.value;
    this.hashtag = hashtag ?? this.hashtag;
    this.building_floor = building_floor ?? this.building_floor;
    this.premium = premium ?? this.premium;
  }

  Future<void> saveZip() async {
    isLoading.value = true;

    try {
      print('** in Save --------------');

      String url = 'https://api.teamwaf.app/v1/zip';

      print("controller attachments: "+attachments);
      print("controller direction: "+direction);
      print("controller checkedAt: "+checked_at.toIso8601String());
      print("controller total_floor: "+total_floor.toString());
      print("controller building_floor: "+building_floor.toString());
      print("controller buildingType: "+buildingType);
      print("controller deposit: "+deposit.toString());
      print("controller fee: "+fee.toString());
      print("controller available: "+available.toIso8601String());
      print("controller m2: "+m2.toString());
      print("controller location: "+location);
      print("controller showYes: "+showYes.toString());
      print("controller note: "+note);
      print("controller room: "+room.toString());
      print("controller toilet: "+toilet.toString());
      print("controller maintenance_fee: "+maintenance_fee.toString());
      print("controller premium: "+DateTime.now().toIso8601String());
      print("controller hashtag: "+hashtag);

      String input = jsonEncode({
        "attachments": 'add',
        "agentId": "명진 부동산777",
        "checkedAt": checked_at.toIso8601String(),
        "estateId": "666",
        "direction": direction.toString(),
        "totalFloor": total_floor.toString(),
        "buildingFloor": building_floor.toString(),
        "buildingType": buildingType.toString(),
        "deposit": deposit.toString(),
        "fee": fee.toString(),
        "available": available.toIso8601String(),
        "hashtag": hashtag.toString(),
        "m2": m2.toString(),
        "location": location.toString(),
        "showYes": showYes.toString(),
        "note": note.toString(),
        "room": room.toString(),
        "toilet": toilet.toString(),
        "maintenanceFee": maintenance_fee.toString(),
        "premium": DateTime.now().toIso8601String()
      });


      print('** input: $input');

      final response = await http.post(Uri.parse(url),
          headers: {'content-type': 'application/json'}, body: input);
      if (response.statusCode == 200) {
        print("저장성공!!!!!!!!!!!!!!!!");
        List<dynamic> responseData =
        jsonDecode(utf8.decode(response.bodyBytes));
        jsonData.assignAll(responseData.cast<Map<String, dynamic>>());
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      error.value = 'Error fetching data: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateZip(String id) async {
    isLoading.value = true;

    try {
      print('** in update --------------');

      String url = 'https://api.teamwaf.app/v1/zip';

      print("controller attachments: "+attachments);
      print("controller direction: "+direction);
      print("controller checkedAt: "+checked_at.toIso8601String());
      print("controller total_floor: "+total_floor.toString());
      print("controller building_floor: "+building_floor.toString());
      print("controller buildingType: "+buildingType);
      print("controller deposit: "+deposit.toString());
      print("controller fee: "+fee.toString());
      print("controller available: "+available.toIso8601String());
      print("controller m2: "+m2.toString());
      print("controller location: "+location);
      print("controller showYes: "+showYes.toString());
      print("controller note: "+note);
      print("controller room: "+room.toString());
      print("controller toilet: "+toilet.toString());
      print("controller maintenance_fee: "+maintenance_fee.toString());
      print("controller premium: "+DateTime.now().toIso8601String());
      print("controller hashtag: "+hashtag);

      String update = jsonEncode({
        "id": id,
        "attachments": 'add',
        "agentId": "명진 부동산88",
        "checkedAt": checked_at.toIso8601String(),
        "estateId": estate.toString(),
        "direction": direction.toString(),
        "totalFloor": total_floor.toString(),
        "buildingFloor": building_floor.toString(),
        "buildingType": buildingType.toString(),
        "deposit": deposit.toString(),
        "fee": fee.toString(),
        "available": available.toIso8601String(),
        "hashtag": hashtag.toString(),
        "m2": m2.toString(),
        "location": location.toString(),
        "showYes": showYes.toString(),
        "note": note.toString(),
        "room": room.toString(),
        "toilet": toilet.toString(),
        "maintenanceFee": maintenance_fee.toString(),
        "premium": DateTime.now().toIso8601String()
      });

      print('** update: $update');

      final response = await http.put(Uri.parse(url),
          headers: {'content-type': 'application/json'}, body: update);
      if (response.statusCode == 200) {
        print("수정 성공!!!!!!!!!!!!!!!!");
        List<dynamic> responseData =
        jsonDecode(utf8.decode(response.bodyBytes));
        jsonData.assignAll(responseData.cast<Map<String, dynamic>>());
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      error.value = 'Error fetching data: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
