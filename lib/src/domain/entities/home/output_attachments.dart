import 'package:equatable/equatable.dart';

class OutPutAttachments extends Equatable {
  final int id;
  final String name;
  final String attachment;
  final bool isPdf;

  const OutPutAttachments({
    this.id = 0,
    this.name = "",
    this.attachment = "",
    this.isPdf = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        attachment,
        isPdf,
      ];
}
