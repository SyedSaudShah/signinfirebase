// ignore: file_names

class NameModal {
  String uid;
  String name;

  NameModal({
    required this.uid,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
      };

  static fromJson(Map<String, dynamic> json) => NameModal(
        uid: json['uid'],
        name: json['name'],
      );
}
