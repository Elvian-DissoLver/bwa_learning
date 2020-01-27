enum School {
  SD,
  SLTP,
  SLTA
}

enum ClassEnum {
  I, II, III, IV, V, VI,
  VII, VIII, IX,
  X, XI, XII
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
          return ClassEnum.X;
        } else if(level == 1) {
          return ClassEnum.XI;
        } else if(level == 2) {
          return ClassEnum.XII;
        }
        break;

      case School.SLTP:
        if(level == 0) {
          return ClassEnum.VII;
        } else if(level == 1) {
          return ClassEnum.VIII;
        } else if(level == 2) {
          return ClassEnum.IX;
        }
        break;

      case School.SD:
        if(level == 0) {
          return ClassEnum.I;
        } else if(level == 1) {
          return ClassEnum.II;
        } else if(level == 2) {
          return ClassEnum.III;
        } else if(level == 3) {
          return ClassEnum.IV;
        } else if(level == 4) {
          return ClassEnum.V;
        } else if(level == 5) {
          return ClassEnum.VI;
        }

        break;
      default:
        return null;
    }
    return null;
  }

}