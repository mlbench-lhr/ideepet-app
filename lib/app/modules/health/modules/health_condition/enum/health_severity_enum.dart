enum SeverityHealthEnum {
  NOT_SERIOUS,
  SLIGHTLY_SERIOUS,
  SERIOUS,
  VERY_SERIOUS,
}

String severityHealthToString(SeverityHealthEnum severity) {
  switch (severity) {
    case SeverityHealthEnum.NOT_SERIOUS:
      return "Não grave";

    case SeverityHealthEnum.SLIGHTLY_SERIOUS:
      return "Pouco grave";

    case SeverityHealthEnum.SERIOUS:
      return "Grave";

    case SeverityHealthEnum.VERY_SERIOUS:
      return "Gravíssimo";
  }
}

SeverityHealthEnum severityHealthFromString(String severity) {
  switch (severity) {
    case "Não grave":
      return SeverityHealthEnum.NOT_SERIOUS;
    case "Pouco grave":
      return SeverityHealthEnum.SLIGHTLY_SERIOUS;
    case "Grave":
      return SeverityHealthEnum.SERIOUS;
    case "Gravíssimo":
      return SeverityHealthEnum.VERY_SERIOUS;
    default:
      return SeverityHealthEnum.NOT_SERIOUS;
  }
}

SeverityHealthEnum parseSeverityHealth(String severity) {
  switch (severity) {
    case "NOT_SERIOUS":
      return SeverityHealthEnum.NOT_SERIOUS;

    case "SLIGHTLY_SERIOUS":
      return SeverityHealthEnum.SLIGHTLY_SERIOUS;

    case "SERIOUS":
      return SeverityHealthEnum.SERIOUS;

    case "VERY_SERIOUS":
      return SeverityHealthEnum.VERY_SERIOUS;

    default:
      return SeverityHealthEnum.NOT_SERIOUS;
  }
}
