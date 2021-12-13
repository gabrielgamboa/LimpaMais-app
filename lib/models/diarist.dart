class Diarist {
  String? name;
  String? email;
  String? phone;
  String? street;
  String? number;
  String? city;
  String? state;
  double? dailyRate;
  String? password;

  Diarist(
      {this.name,
      this.email,
      this.phone,
      this.street,
      this.number,
      this.city,
      this.state,
      this.dailyRate,
      this.password});

  Diarist.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    street = json['street'];
    number = json['number'];
    city = json['city'];
    state = json['state'];
    dailyRate = json['daily_rate'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['street'] = this.street;
    data['number'] = this.number;
    data['city'] = this.city;
    data['state'] = this.state;
    data['daily_rate'] = this.dailyRate;
    data['password'] = this.password;
    return data;
  }
}