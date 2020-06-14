package com.codesquad.issuetracker.issue.web.model;

import java.util.LinkedHashSet;
import java.util.Set;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public class IssueQuery {

  private final String title;
  private final String description;
  private final Set<Long> idOfLabels;

  public static IssueQuery of(String title, String description, LinkedHashSet<Long> idOfLabels) {
    return new IssueQuery(title, description, idOfLabels);
  }
}
