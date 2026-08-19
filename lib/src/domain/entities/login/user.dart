import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String image;
  final String email;

  const User({
    this.id = 0,
    this.name = '',
    this.image = '',
    this.email = '',
  });

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        email,
      ];
}
