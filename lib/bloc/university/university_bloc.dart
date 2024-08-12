import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_app/model/university_model.dart';
import 'package:test_app/repository/univeristy_repository.dart';

part 'university_event.dart';
part 'university_state.dart';

class UniversityBloc extends HydratedBloc<UniversityEvent, UniversityState> {
  final UniversityRepository dataRepo = UniversityRepository();

  UniversityBloc() : super(UniversityInitial()) {
    on<UniversityEvent>((event, emit) async {
      if (event is FetchUniversityData) {
        if (state is uniDataloaded) {
          emit(state);
        } else {
          emit(uniDataLoading());
          try {
            final universityData = await dataRepo.fetchUniversityData();
            emit(uniDataloaded(universityData));
          } catch (e) {
            print('Error: $e');
            emit(uniDataError());
          }
        }
      }

      if (event is DeleteData) {
        if (state is uniDataloaded) {
          final currentState = state as uniDataloaded;
          final updatedUniversities = List<University>.from(currentState.data)
            ..removeWhere((u) => u.name == event.university.name);

          emit(uniDataloaded(updatedUniversities));
        }
      }
    });
  }

  @override
  UniversityState? fromJson(Map<String, dynamic> json) {
    try {
      final universities = (json['universities'] as List)
          .map((universityJson) => University.fromJson(universityJson))
          .toList();
      return uniDataloaded(universities);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(UniversityState state) {
    if (state is uniDataloaded) {
      return {
        'universities': state.data.map((u) => u.toJson()).toList(),
      };
    }
    return null;
  }
}
