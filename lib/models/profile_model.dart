class ProfileModel {
  final String id;
  final String name;

  // IDs
  final String? instagram;
  final String? linkedin;
  final String? email;
  final String? phone;
  final String? upi;
  final String? x; // Twitter

  // Card Design
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

  // Convert to Map (for storage later)
  Map<String, dynamic> toMap() {
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

  // Convert from Map
  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'],
      name: map['name'],
      instagram: map['instagram'],
      linkedin: map['linkedin'],
      email: map['email'],
      phone: map['phone'],
      upi: map['upi'],
      x: map['x'],
      cardType: map['cardType'],
      gradientColors: map['gradientColors'] != null
          ? List<String>.from(map['gradientColors'])
          : null,
      fontStyle: map['fontStyle'],
    );
  }
}