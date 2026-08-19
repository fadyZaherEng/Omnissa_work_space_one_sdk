import 'package:equatable/equatable.dart';

class Sort extends Equatable {
  final int id;
  final String name;

  const Sort({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];

  Sort copyWith({
    int? id,
    String? name,
  }) {
    return Sort(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  //to json
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  //from json
  factory Sort.fromMap(Map<String, dynamic> map) {
    return Sort(
      id: map['id']?.toInt() ?? -1,
      name: map['name'] ?? '',
    );
  }
}
