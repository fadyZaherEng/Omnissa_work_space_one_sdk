import 'package:equatable/equatable.dart';
import 'package:mofa/src/domain/entities/home/home_statics_item.dart';

class HomeStatistics extends Equatable {
  final String title;
  final List<HomeStaticsItem> items;
  final bool visible;

  const HomeStatistics({
    this.title = '',
    this.items = const [],
    this.visible = false,
  });

  @override
  List<Object?> get props => [title, items, visible];
}
