import 'dart:convert';

class Cartitem {
  String img;
  String name;
  num price;
  int quantity;
  Cartitem({
    required this.img,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  Cartitem copyWith({
    String? img,
    String? name,
    num? price,
    int? quantity,
  }) {
    return Cartitem(
      img: img ?? this.img,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'img': img,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }

  factory Cartitem.fromMap(Map<String, dynamic> map) {
    return Cartitem(
      img: map['img'] as String,
      name: map['name'] as String,
      price: map['price'] as num,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cartitem.fromJson(String source) =>
      Cartitem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cartitem(img: $img, name: $name, price: $price, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant Cartitem other) {
    if (identical(this, other)) return true;

    return other.img == img &&
        other.name == name &&
        other.price == price &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return img.hashCode ^ name.hashCode ^ price.hashCode ^ quantity.hashCode;
  }
}
