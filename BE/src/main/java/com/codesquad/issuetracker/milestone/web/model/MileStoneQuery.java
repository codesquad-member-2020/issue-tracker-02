package com.codesquad.issuetracker.milestone.web.model;


import com.codesquad.issuetracker.issue.data.Issue;
import java.time.LocalDate;
import java.util.List;
import lombok.Getter;

@Getter
public class MileStoneQuery {

  private String title;
  private String description;
  private LocalDate dueDate;
  private List<Issue> issues;
}
