class Localization {
  final String code;
  final String locale;
  final String message;
  final String module;

  // Constructor
  Localization({
    required this.code,
    required this.locale,
    required this.message,
    required this.module,
  });

  // Factory constructor to create an instance from JSON
  factory Localization.fromJson(Map<String, dynamic> json) {
    return Localization(
      code: json['code'] as String,
      locale: json['locale'] as String,
      message: json['message'] as String,
      module: json['module'] as String,
    );
  }

  // Optional: Method to convert an instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'locale': locale,
      'message': message,
      'module': module,
    };
  }
}

class Language{
  late String label;
  late String value;

  Language(this.label,this.value);
}