import 'package:dio/dio.dart';
import 'package:test_app/model/university_model.dart';

class UniversityRepository {
  final String apiUrl = "http://universities.hipolabs.com/search?country=United+States";
  final Dio _dio = Dio();

  Future<List<University>> fetchUniversityData() async {
    try {
      final response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        
        List<University> universities = (response.data as List)
            .map((json) => University.fromJson(json))
            .toList();
        return universities;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<List<University>> deleteUniversity(University university) async {
  
    List<University> universities = await fetchUniversityData();
    universities.remove(university);
    return universities;
  }
}
