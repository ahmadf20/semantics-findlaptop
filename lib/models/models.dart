import 'dart:convert';

Laptop laptopFromJson(String str) => Laptop.fromJson(json.decode(str));

String laptopToJson(Laptop data) => json.encode(data.toJson());

class Laptop {
  Laptop({
    this.company,
    this.product,
    this.typeName,
    this.inches,
    this.screenResolution,
    this.cpu,
    this.ram,
    this.memory,
    this.gpu,
    this.opSys,
    this.weight,
    this.price,
  });

  String? company;
  String? product;
  String? typeName;
  String? inches;
  String? screenResolution;
  String? cpu;
  String? ram;
  String? memory;
  String? gpu;
  String? opSys;
  String? weight;
  String? price;

  factory Laptop.fromJson(Map<String, dynamic> json) => Laptop(
        company: json["company"],
        product: json["product"],
        typeName: json["typeName"],
        inches: json["inches"],
        screenResolution: json["screenResolution"],
        cpu: json["cpu"],
        ram: json["ram"],
        memory: json["memory"],
        gpu: json["gpu"],
        opSys: json["opSys"],
        weight: json["weight"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "company": company,
        "product": product,
        "typeName": typeName,
        "inches": inches,
        "screenResolution": screenResolution,
        "cpu": cpu,
        "ram": ram,
        "memory": memory,
        "gpu": gpu,
        "opSys": opSys,
        "weight": weight,
        "price": price,
      };
}
