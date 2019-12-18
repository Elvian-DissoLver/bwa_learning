enum School {
  SD,
  SLTP,
  SLTA
}

enum ClassEnum {
  KELAS_I, KELAS_II, KELAS_III, KELAS_IV, KELAS_V, KELAS_VI,
  KELAS_VII, KELAS_VIII, KELAS_IX,
  KELAS_X, KELAS_XI, KELAS_XII
}

class SchoolHelper{

//  static School getSchoolFromString(String value) {
//    switch(value){
//      case "SLTA":
//        return School.SLTA;
//      default:
//        return null;
//    }
//  }

  static int getIteration(School school){
    switch(school){
      case School.SD:
        return 6;
      case School.SLTP:
        return 3;
      case School.SLTA:
        return 3;
      default:
        return 0;
    }
  }

  static ClassEnum getClassEnum(School school, int level){
    switch(school) {
      case School.SLTA:
        if(level == 0) {
          return ClassEnum.KELAS_X;
        } else if(level == 1) {
          return ClassEnum.KELAS_XI;
        } else if(level == 2) {
          return ClassEnum.KELAS_XII;
        }
        break;

      case School.SLTP:
        if(level == 0) {
          return ClassEnum.KELAS_VII;
        } else if(level == 1) {
          return ClassEnum.KELAS_VIII;
        } else if(level == 2) {
          return ClassEnum.KELAS_IX;
        }
        break;

      case School.SD:
        if(level == 0) {
          return ClassEnum.KELAS_I;
        } else if(level == 1) {
          return ClassEnum.KELAS_II;
        } else if(level == 2) {
          return ClassEnum.KELAS_III;
        } else if(level == 3) {
          return ClassEnum.KELAS_IV;
        } else if(level == 4) {
          return ClassEnum.KELAS_V;
        } else if(level == 5) {
          return ClassEnum.KELAS_VI;
        }

        break;
      default:
        return null;
    }
    return null;
  }

}