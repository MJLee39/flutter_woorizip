// models/account.dart
class Account {
  final String id;
  final String provider;
  final String providerUserId;
  final String nickname;
  final String role;
  final String licenseId;
  final String profileImageId;
  final String premiumDate;
  final String phone;

  Account({
    required this.id,
    required this.provider,
    required this.providerUserId,
    required this.nickname,
    required this.role,
    required this.licenseId,
    required this.profileImageId,
    required this.premiumDate,
    required this.phone,
  });

  Account copyWith({
    String? id,
    String? provider,
    String? providerUserId,
    String? nickname,
    String? role,
    String? licenseId,
    String? profileImageId,
    String? premiumDate,
    String? phone,
  }) {
    return Account(
      id: id ?? this.id,
      provider: provider ?? this.provider,
      providerUserId: providerUserId ?? this.providerUserId,
      nickname: nickname ?? this.nickname,
      role: role ?? this.role,
      licenseId: licenseId ?? this.licenseId,
      profileImageId: profileImageId ?? this.profileImageId,
      premiumDate: premiumDate ?? this.premiumDate,
      phone: phone ?? this.phone,
    );
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['Id'],
      provider: json['Provider'],
      providerUserId: json['ProviderUserId'],
      nickname: json['Nickname'],
      role: json['Role'],
      licenseId: json['LicenseId'],
      profileImageId: json['ProfileImageId'],
      premiumDate: json['PremiumDate'],
      phone: json['Phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Provider': provider,
      'ProviderUserId': providerUserId,
      'Nickname': nickname,
      'Role': role,
      'LicenseId': licenseId,
      'ProfileImageId': profileImageId,
      'PremiumDate': premiumDate,
      'Phone': phone,
    };
  }
}