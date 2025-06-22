import 'package:main/domain/models/trail.dart';

class HomeFilters {
  static List<Trail> filterByDifficulty(List<Trail> trails, int? selectedGrade) {
    return trails.where((trail) {
      if (selectedGrade == null) return true;
      final grade = trail.grade;
      switch (selectedGrade) {
        case 0:
          return grade == 'hiking';
        case 1:
          return grade == 'mountain_hiking';
        case 2:
          return grade == 'demanding_mountain_hiking' ||
                 grade == 'alpine_hiking' ||
                 grade == 'demanding_alpine_hiking';
        case 3:
          return grade == 'difficult_alpine_hiking';
        default:
          return true;
      }
    }).toList();
  }

  static List<Trail> filterByLenght(List<Trail> trails, int? selectedLenght) {
    return trails.where((trail) {
      if (selectedLenght == null) return true;
      final length = trail.length;
      switch (selectedLenght) {
        case 0:
          return length < 3000;
        case 1:
          return length >= 3000 && length < 7000;
        case 2:
          return length >= 7000 && length < 15000;
        case 3:
          return length >= 15000;
        default:
          return true;
      }
    }).toList();
  }
}