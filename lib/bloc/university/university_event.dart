part of 'university_bloc.dart';


sealed class UniversityEvent {}

class FetchUniversityData extends UniversityEvent {

}

class DeleteData extends UniversityEvent {
  final University university;

  DeleteData(this.university);
}
