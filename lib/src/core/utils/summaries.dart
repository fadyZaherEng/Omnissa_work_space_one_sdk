enum Summaries {
  Milestones,
  KPIs,
  Tasks,
  Approvals,
  Projects,
  Risks,
  Issues,
  Deliverables,


}

Summaries parseSummaryArabic(String value, Summaries defaultValue) {
  if (defaultValue.name == value) {
    return defaultValue;
  } else if (value == "المعالم") {
    return Summaries.Milestones;
  } else if (value == "المؤشرات") {
    return Summaries.KPIs;
  } else if (value == "المهام") {
    return Summaries.Tasks;
  } else if (value == "الاعتمادات") {
    return Summaries.Approvals;
  }else if (value == "المشاريع") {
    return Summaries.Projects;
  } else if (value == "المخاطر") {
    return Summaries.Risks;
  } else if (value == "التحديات") {
    return Summaries.Issues;
  } else if (value == "المخرجات") {
    return Summaries.Deliverables;
  }
  else {
    return Summaries.Milestones;
  }
}

Summaries parseSummary(String value) {
  return Summaries.values.firstWhere(
    (e) => parseSummaryArabic(value, e) == e,
    orElse: () => Summaries.Milestones,
  );
}

Summaries parseSummaryEnglish(String value) {
  return Summaries.values.firstWhere(
    (e) => e.name == value,
    orElse: () => Summaries.Milestones,
  );
}
