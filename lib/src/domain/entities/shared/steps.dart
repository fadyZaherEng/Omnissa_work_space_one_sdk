import 'package:equatable/equatable.dart';

class Steps extends Equatable {
  final int id;
  final String name;

  const Steps({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
