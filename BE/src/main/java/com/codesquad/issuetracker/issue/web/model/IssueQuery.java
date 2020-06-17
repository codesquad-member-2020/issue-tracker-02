package com.codesquad.issuetracker.issue.web.model;

import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Set;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class IssueQuery {

  private final String title;
  private final String description;

  @Builder.Default
  private final Set<Long> idOfLabels = new LinkedHashSet<>();

  @Builder.Default
  private final Set<Long> idOfMilestones = new HashSet<>();
}
