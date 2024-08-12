class University {
  String? alphaTwoCode;
  List<String>? webPages;
  String? country;
  List<String>? domains;
  String? name;
  String? stateProvince;

  University({
    this.alphaTwoCode,
    this.webPages,
    this.country,
    this.domains,
    this.name,
    this.stateProvince,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      alphaTwoCode: json['alpha_two_code'],
      webPages: List<String>.from(json['web_pages']),
      country: json['country'],
      domains: List<String>.from(json['domains']),
      name: json['name'],
      stateProvince: json['state-province'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'alpha_two_code': alphaTwoCode,
      'web_pages': webPages,
      'country': country,
      'domains': domains,
      'name': name,
      'state-province': stateProvince,
    };
  }
}
