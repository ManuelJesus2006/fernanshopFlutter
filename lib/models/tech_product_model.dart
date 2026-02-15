import 'dart:convert';

List<TechProduct> techProductFromJson(String str) => 
    List<TechProduct>.from(json.decode(str).map((x) => TechProduct.fromJson(x)));

String techProductToJson(List<TechProduct> data) => 
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TechProduct {
  int id;
  String business;
  String name;
  String type;
  double price;
  String imageUrl;
  DateTime? releaseDate;
  Characteristics? characteristics;
  DateTime? creationDate;
  DateTime? updateDate;

  TechProduct({
    required this.id,
    required this.business,
    required this.name,
    required this.type,
    required this.price,
    required this.imageUrl,
    this.releaseDate,
    this.characteristics,
    this.creationDate,
    this.updateDate,
  });

  factory TechProduct.fromJson(Map<String, dynamic> json) => TechProduct(
        id: json["id"],
        business: json["business"] ?? '',
        name: json["name"] ?? '',
        type: json["type"] ?? '',
        price: (json["price"] ?? 0).toDouble(),
        imageUrl: json["imageUrl"] ?? '',
        releaseDate: json["release_date"] == null ? null : DateTime.tryParse(json["release_date"]),
        characteristics: json["characteristics"] == null ? null : Characteristics.fromJson(json["characteristics"]),
        creationDate: json["creation_date"] == null ? null : DateTime.tryParse(json["creation_date"]),
        updateDate: json["update_date"] == null ? null : DateTime.tryParse(json["update_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "business": business,
        "name": name,
        "type": type,
        "price": price,
        "imageUrl": imageUrl,
        "release_date": releaseDate?.toIso8601String(),
        "characteristics": characteristics?.toJson(),
        "creation_date": creationDate?.toIso8601String(),
        "update_date": updateDate?.toIso8601String(),
      };
}

class Characteristics {
  String? speed;
  String? maxSpeed;
  String? voltage;
  String? memory;
  String? boostClock;
  String? tdp;
  String? socket;
  String? chipset;
  String? formFactor;
  String? type;
  String? characteristicsInterface;
  String? speedRead;
  String? speedWrite;
  String? rpm;
  String? cache;
  String? fans;
  String? noise;
  String? height;
  String? fan;
  String? wattage;
  String? efficiency;
  String? modular;

  Characteristics({
    this.speed,
    this.maxSpeed,
    this.voltage,
    this.memory,
    this.boostClock,
    this.tdp,
    this.socket,
    this.chipset,
    this.formFactor,
    this.type,
    this.characteristicsInterface,
    this.speedRead,
    this.speedWrite,
    this.rpm,
    this.cache,
    this.fans,
    this.noise,
    this.height,
    this.fan,
    this.wattage,
    this.efficiency,
    this.modular,
  });

  factory Characteristics.fromJson(Map<String, dynamic> json) => Characteristics(
        speed: json["speed"],
        maxSpeed: json["max_speed"],
        voltage: json["voltage"],
        memory: json["memory"],
        boostClock: json["boost_clock"],
        tdp: json["tdp"],
        socket: json["socket"],
        chipset: json["chipset"],
        formFactor: json["form_factor"],
        type: json["type"],
        characteristicsInterface: json["interface"],
        speedRead: json["speed_read"],
        speedWrite: json["speed_write"],
        rpm: json["rpm"],
        cache: json["cache"],
        fans: json["fans"],
        noise: json["noise"],
        height: json["height"],
        fan: json["fan"],
        wattage: json["wattage"],
        efficiency: json["efficiency"],
        modular: json["modular"],
      );

  Map<String, dynamic> toJson() => {
        "speed": speed,
        "max_speed": maxSpeed,
        "voltage": voltage,
        "memory": memory,
        "boost_clock": boostClock,
        "tdp": tdp,
        "socket": socket,
        "chipset": chipset,
        "form_factor": formFactor,
        "type": type,
        "interface": characteristicsInterface,
        "speed_read": speedRead,
        "speed_write": speedWrite,
        "rpm": rpm,
        "cache": cache,
        "fans": fans,
        "noise": noise,
        "height": height,
        "fan": fan,
        "wattage": wattage,
        "efficiency": efficiency,
        "modular": modular,
      };
}