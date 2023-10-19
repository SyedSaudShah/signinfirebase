// ignore: file_names
// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names, duplicate_ignore
import 'dart:convert';

class GetImage {
  String img;
  String name;
  num price;
  GetImage({
    required this.img,
    required this.name,
    required this.price,
  });

  GetImage copyWith({
    String? img,
    String? name,
    num? price,
  }) {
    return GetImage(
      img: img ?? this.img,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'img': img,
      'name': name,
      'price': price,
    };
  }

  factory GetImage.fromMap(Map<String, dynamic> map) {
    return GetImage(
      img: map['img'] as String,
      name: map['name'] as String,
      price: map['price'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetImage.fromJson(String source) =>
      GetImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GetImage(img: $img, name: $name, price: $price)';

  @override
  bool operator ==(covariant GetImage other) {
    if (identical(this, other)) return true;

    return other.img == img && other.name == name && other.price == price;
  }

  @override
  int get hashCode => img.hashCode ^ name.hashCode ^ price.hashCode;
}
