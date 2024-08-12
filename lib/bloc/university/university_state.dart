part of 'university_bloc.dart';

@immutable
sealed class UniversityState {}

final class UniversityInitial extends UniversityState {}

final class uniDataLoading extends UniversityState {}

final class uniDataloaded extends UniversityState {
  final List<University> data;

  uniDataloaded(this.data);
}

final class uniDataError extends UniversityState {}
