class Condition {
  final String accountId;
  final String location;
  final String buildingType;
  final int fee;
  final String moveInDate;
  final String hashtag;

  Condition({
    required this.accountId,
    required this.location,
    required this.buildingType,
    required this.fee,
    required this.moveInDate,
    required this.hashtag,
  });

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      accountId: json['accountId'],
      location: json['location'],
      buildingType: json['buildingType'],
      fee: json['fee'],
      moveInDate: json['moveInDate'],
      hashtag: json['hashtag'],
    );
  }
}
