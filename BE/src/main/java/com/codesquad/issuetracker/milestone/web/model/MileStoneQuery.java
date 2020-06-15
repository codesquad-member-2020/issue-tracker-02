package com.codesquad.issuetracker.milestone.web.model;


import com.codesquad.issuetracker.issue.data.Issue;
import java.time.LocalDate;
import java.util.List;
import lombok.Builder;
import lombok.Getter;

@Getter
public class MileStoneQuery {

  private final String title;
  private final String description;
  private final LocalDate dueDate;
  private final List<Issue> issues;

  @Builder
  private MileStoneQuery(String title, String description, LocalDate dueDate, List<Issue> issues) {
    this.title = title;
    this.description = description;
    this.dueDate = dueDate;
    this.issues = issues;
  }

  public static MileStoneQuery of(String title, String description, LocalDate dueDate,
      List<Issue> issues) {
    return new MileStoneQuery(title, description, dueDate, issues);
  }
}
