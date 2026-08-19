import 'package:equatable/equatable.dart';
import 'package:mofa/src/domain/entities/home/challenges.dart';
import 'package:mofa/src/domain/entities/home/complinace.dart';
import 'package:mofa/src/domain/entities/home/land_mark.dart';
import 'package:mofa/src/domain/entities/home/out_put.dart';
import 'package:mofa/src/domain/entities/home/project.dart';
import 'package:mofa/src/domain/entities/home/risks.dart';

class ProjectDetails extends Equatable {
  final Project project; //nfo
  final List<OutPut> deliverables; //output
  final List<Landmark> milestones; //landmark
  final List<Challenges> issues; //challenge
  final List<Risks> risks; //risk
  final List<Complinace> compliance; //risk
//assumptions = notes

  const ProjectDetails({
    this.project = const Project(),
    this.deliverables = const [],
    this.milestones = const [],
    this.issues = const [],
    this.risks = const [],
    this.compliance = const [],
  });

  @override
  List<Object> get props => [
        project,
        deliverables,
        milestones,
        issues,
        risks,
        compliance,
      ];
}
