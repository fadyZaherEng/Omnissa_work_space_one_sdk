import 'package:equatable/equatable.dart';

class HomeStaticsItem extends Equatable {
  final String label;
  final String color;
  final int count;

  const HomeStaticsItem({
    this.label = '',
    this.color = '#00b050',
    this.count = 0,
  });

  factory HomeStaticsItem.fromJson(Map<String, dynamic> json) {
    return HomeStaticsItem(
      label: json['label'],
      color: json['color'],
      count: json['count'],
    );
  }

  @override
  List<Object?> get props => [label, color, count];
}
