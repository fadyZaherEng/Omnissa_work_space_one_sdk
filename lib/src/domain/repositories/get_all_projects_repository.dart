import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/department.dart';
import 'package:mofa/src/domain/entities/home/owner.dart';
import 'package:mofa/src/domain/entities/home/project.dart';
import 'package:mofa/src/domain/entities/home/project_details.dart';
import 'package:mofa/src/domain/entities/home/status_model.dart';

abstract class GetAllProjectsRepository {
  Future<DataState<List<Project>>> getAllProjects({
    required int pageSize,
    required int skip,
    required int status,
    required String departmentId,
    required String owner,
    required String searchValue,
    required String searchFilterDefinition,
    required String sortColumnDirection,
    required String columnDirection,
  });

  Future<DataState<ProjectDetails>> getProjectFullDetials({
    required String projectId,
    required String searchValue,
    required String draw,
    required int pageSize,
    required int skip,
  });

  Future<DataState<List<Department>>> getProjectDepartments();

  Future<DataState<List<StatusModel>>> getProjectStatus();

  Future<DataState<List<GetOwner>>> getProjectOwners();
}
