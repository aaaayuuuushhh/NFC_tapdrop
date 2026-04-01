class DeviceModel {
  final String deviceId;
  final String deviceName;

  // 🔹 Optional (for future use)
  final String? platform; // Android / iOS
  final DateTime? connectedAt;

  DeviceModel({
    required this.deviceId,
    required this.deviceName,
    this.platform,
    this.connectedAt,
  });

  // 🔥 Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'deviceName': deviceName,
      'platform': platform,
      'connectedAt': connectedAt?.toIso8601String(),
    };
  }

  // 🔥 Convert from JSON
  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      deviceId: json['deviceId'] ?? '',
      deviceName: json['deviceName'] ?? '',
      platform: json['platform'],
      connectedAt: json['connectedAt'] != null
          ? DateTime.parse(json['connectedAt'])
          : null,
    );
  }

  // 🔥 Copy method (future use)
  DeviceModel copyWith({
    String? deviceId,
    String? deviceName,
    String? platform,
    DateTime? connectedAt,
  }) {
    return DeviceModel(
      deviceId: deviceId ?? this.deviceId,
      deviceName: deviceName ?? this.deviceName,
      platform: platform ?? this.platform,
      connectedAt: connectedAt ?? this.connectedAt,
    );
  }
}