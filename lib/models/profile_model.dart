class ProfileModel {
  final String id;
  final String name;

  // 🔹 Social / Contact IDs
  final String? instagram;
  final String? linkedin;
  final String? email;
  final String? phone;
  final String? upi;
  final String? x; // Twitter

  // 🔹 Card Customization (future ready)
  final String? cardType; // minimal, glass, gradient
  final List<String>? gradientColors;
  final String? fontStyle;

  ProfileModel({
    required this.id,
    required this.name,
    this.instagram,
    this.linkedin,
    this.email,
    this.phone,
    this.upi,
    this.x,
    this.cardType,
    this.gradientColors,
    this.fontStyle,
  });

  // 🔥 Convert to JSON (for storage)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'instagram': instagram,
      'linkedin': linkedin,
      'email': email,
      'phone': phone,
      'upi': upi,
      'x': x,
      'cardType': cardType,
      'gradientColors': gradientColors,
      'fontStyle': fontStyle,
    };
  }

  // 🔥 Convert from JSON
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      instagram: json['instagram'],
      linkedin: json['linkedin'],
      email: json['email'],
      phone: json['phone'],
      upi: json['upi'],
      x: json['x'],
      cardType: json['cardType'],
      gradientColors: json['gradientColors'] != null
          ? List<String>.from(json['gradientColors'])
          : null,
      fontStyle: json['fontStyle'],
    );
  }

  // 🔥 Copy method (VERY useful later)
  ProfileModel copyWith({
    String? id,
    String? name,
    String? instagram,
    String? linkedin,
    String? email,
    String? phone,
    String? upi,
    String? x,
    String? cardType,
    List<String>? gradientColors,
    String? fontStyle,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      instagram: instagram ?? this.instagram,
      linkedin: linkedin ?? this.linkedin,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      upi: upi ?? this.upi,
      x: x ?? this.x,
      cardType: cardType ?? this.cardType,
      gradientColors: gradientColors ?? this.gradientColors,
      fontStyle: fontStyle ?? this.fontStyle,
    );
  }
}