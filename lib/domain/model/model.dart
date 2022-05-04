class SliderObject {
  String title;
  String subtitle;
  String imagePath;

  SliderObject(
      {required this.title, required this.subtitle, required this.imagePath});
}

class Customer {
  String id;
  String name;
  int numberOfNotification;

  Customer(this.id, this.name, this.numberOfNotification);
}

class Contact {
  String phone;
  String email;
  String link;

  Contact(this.phone, this.email, this.link);
}

class Authentication {
  Customer? customer;
  Contact? contact;

  Authentication(this.customer, this.contact);
}

class DeviceInfo {
  String name;
  String identifire;
  String version;

  DeviceInfo(this.name, this.identifire, this.version);
}
