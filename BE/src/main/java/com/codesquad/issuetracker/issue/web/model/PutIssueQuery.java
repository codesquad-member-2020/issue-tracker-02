package com.codesquad.issuetracker.issue.web.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class PutIssueQuery {

  private final String title;
  private final String description;
}
